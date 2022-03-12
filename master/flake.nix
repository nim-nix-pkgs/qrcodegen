{
  description = ''QR Code Generator'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-qrcodegen-master.flake = false;
  inputs.src-qrcodegen-master.owner = "bunkford";
  inputs.src-qrcodegen-master.ref   = "refs/heads/master";
  inputs.src-qrcodegen-master.repo  = "qrcodegen";
  inputs.src-qrcodegen-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-qrcodegen-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-qrcodegen-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}