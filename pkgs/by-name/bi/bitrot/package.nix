{
  fetchFromGitHub,
  python3Packages,
  lib,
}:

python3Packages.buildPythonPackage rec {
  pname = "bitrot";
  version = "1.0.1";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "ambv";
    repo = "bitrot";
    rev = "87e15913a5b03bb32d8172d33e988329b1dce07b";
    sha256 = "sha256-L370TXriRhTe2KSibJr5tZDWqxIr1Z+8hDsC2CaKyGI=";
  };

  propagatedBuildInputs = with python3Packages; [
    setuptools
    setuptools-scm
  ];

  pythonImportsCheck = [ "bitrot" ];

  meta = {
    description = "Detects bit rotten files on the hard drive";
    homepage = "https://github.com/ambv/bitrot";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ kmogged ];
    mainProgram = "bitrot";
  };
}
