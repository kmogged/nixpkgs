{
  lib,
  stdenv,
  fetchFromGitHub,
  SDL2,
  rtmidi,
}:

stdenv.mkDerivation {
  pname = "sidfactory2";
  version = "20260308";

  src = fetchFromGitHub {
    owner = "Chordian";
    repo = "sidfactory2";
    rev = "d89ae8eb1707b75341c38d61b6e14f7720774785";
    hash = "sha256-WI34c54gjEhzkt8AjtXjiWJKgiVlIbm/D8UCJY+YuTI=";
  };

  buildInputs = [
    SDL2
    rtmidi
  ];

  buildPhase = ''
    make dist
  '';

  installPhase = ''

    ARTIFACT_DIR=$(find artifacts -type d -name "SIDFactoryII_*" | head -n 1)

    cd "$ARTIFACT_DIR" || {
      echo "Error: Could not find build artifacts directory 'SIDFactoryII_*' inside 'artifacts/'"
      exit 1
    }

    install -D -m 555 SIDFactoryII $out/bin/sidfactory2
    install -d $out/bin/overlay
    find drivers -type f -exec install -m 444 -D {} $out/bin/{} \;

  '';

  meta = with lib; {
    description = "SID Factory II - A cross-platform tracker for Commodore 64 music";
    homepage = "https://blog.chordian.net/sf2/";
    license = licenses.gpl2;
    maintainers = with maintainers; [ kmogged ];
    platforms = platforms.linux;
    mainProgram = "sidfactory2";
  };
}
