{ pkgs ? import <nixpkgs> {} }:

with pkgs;

 let
     mavenPackage = buildMaven ./project-info.json;
     mavenBuild = lib.overrideDerivation mavenPackage.build (oldAttrs: {
        installPhase = ''
            mvn --offline --settings ${mavenPackage.settings} package
            mkdir $out
            mv target/*.jar $out
        '';
    });
 in
{
     build = stdenv.mkDerivation rec {
         name = "wordCount-${version}";
         version = "0.0.1";
         src = ./.;
         buildInputs = [ makeWrapper jre ];
         
         installPhase = ''
            mkdir -p $out/{bin,lib}
            cp -r ${mavenBuild}/*.jar $out/lib
            cp ./scripts/wordCount $out/bin
            chmod +x $out/bin/wordCount
            sed -i s@OUT@$out@g $out/bin/wordCount
            wrapProgram $out/bin/wordCount --prefix PATH : ${jre}/bin/
         '';
     };
}
