{
  lib,
  stdenv,
  python3Packages,
  fetchFromGitHub,
  nix-update-script,
  glibcLocales,
  versionCheckHook,
}:
let
  harlequin-mysql = python3Packages.callPackage ./harlequin-mysql.nix { };
in
python3Packages.buildPythonApplication rec {
  pname = "harlequin";
  version = "2.0.0";
  pyproject = true;
  src = fetchFromGitHub {
    owner = "tconbeer";
    repo = "harlequin";
    tag = "v${version}";
    hash = "sha256-IUzN+rWL69TUUS9npcmfSAPqy/8SYNusNAN/muCMqNI=";
  };
  pythonRelaxDeps = [
    "numpy"
    "pyarrow"
    "textual"
    "syrupy"
  ];
  build-system = with python3Packages; [ poetry-core ];
  nativeBuildInputs = [ glibcLocales ];
  dependencies =
    with python3Packages;
    [
      click
      duckdb
      importlib-metadata
      numpy
      packaging
      platformdirs
      questionary
      rich-click
      sqlfmt
      textual
      textual-fastdatatable
      textual-textarea
      tomlkit
      tree-sitter-sql
      harlequin-mysql
    ];
  pythonImportsCheck = [
    "harlequin"
    "harlequin_duckdb"
    "harlequin_sqlite"
    "harlequin_vscode"
  ];
  passthru = {
    updateScript = nix-update-script { };
  };
  preCheck = ''
    export HOME=$(mktemp -d)
  '';
  nativeCheckInputs = with python3Packages; [
    pytest-asyncio
    pytestCheckHook
    versionCheckHook
  ];
  disabledTests = [
    "test_connect_extensions"
    "test_connect_prql"
  ]
  ++ lib.optionals (!stdenv.hostPlatform.isx86_64) [
    "test_load_extension"
  ];
  disabledTestPaths = [
    "tests/functional_tests/"
  ];
  meta = {
    description = "The SQL IDE for Your Terminal";
    homepage = "https://harlequin.sh";
    changelog = "https://github.com/tconbeer/harlequin/releases/tag/v${version}";
    license = lib.licenses.mit;
    mainProgram = "harlequin";
    platforms = lib.platforms.unix;
  };
}
