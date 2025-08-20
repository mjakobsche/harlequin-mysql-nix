{
  lib,
  buildPythonPackage,
  fetchPypi,
  protobuf,
  dnspython,
}:
buildPythonPackage rec {
  pname = "mysql-connector-python";
  version = "9.1.0";
  format = "wheel";

  src = fetchPypi {
    inherit version;
    pname = "mysql_connector_python";
    format = "wheel";
    python = "py2.py3";
    abi = "none";
    platform = "any";
    sha256 = "1cahbl1lz2i4zmjp830k0l0nv5ff1zjklv3213lqmpf79nl1mkys";
  };

  propagatedBuildInputs = [
    protobuf
    dnspython
  ];

  doCheck = false;

  pythonImportsCheck = [
    "mysql.connector"
  ];

  meta = {
    description = "Official MySQL driver written in Python";
    homepage = "https://dev.mysql.com/doc/connector-python/en/";
    license = lib.licenses.gpl2Only;
    platforms = lib.platforms.all;
  };
}
