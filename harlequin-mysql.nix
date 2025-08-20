{
  lib,
  buildPythonPackage,
  fetchPypi,
  poetry-core,
  callPackage,
}:
let
  mysql-connector-python = callPackage ./mysql-connector-python.nix { };
in
buildPythonPackage rec {
  pname = "harlequin-mysql";
  version = "1.1.0";
  pyproject = true;
  
  src = fetchPypi {
    pname = "harlequin_mysql";
    inherit version;
    hash = "sha256-elqC5cLrk4OjBEPTh6E5pFCbERr8L+k1thnmxzQJ7ns=";
  };
  
  build-system = [
    poetry-core
  ];
  
  dependencies = [
    mysql-connector-python
  ];

  doCheck = false;
  
  pythonRemoveDeps = [
    "harlequin"
  ];
  
  meta = {
    description = "A Harlequin adapter for MySQL";
    homepage = "https://pypi.org/project/harlequin-mysql/";
    license = lib.licenses.mit;
  };
}
