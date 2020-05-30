$fn=64;


color([0.3,0.3,0.3]) translate([-25-4,0,0]) difference(){
    minkowski(){
        cube([50,50,50],center=true);
        sphere(r=4);
    }
    for (ax=[0,90]) rotate([ax,0,0]) cylinder(d=30,h=80,center=true);
    
}


color("yellow") translate([0,0,8]) rotate([90,0,90]) text("ASM:20 2020-05-30", halign="center", size=3);

color("yellow") translate([0,0,0]) rotate([90,0,90]) text("OpenSCAD", halign="center", valign="center", size=5);

color("yellow") translate([0,0,-8]) rotate([90,0,90]) text("Workshop", halign="center", valign="center", size=5);

color("yellow") translate([0,0,-22]) rotate([90,0,90]) text("iggy@muc.ccc.de", halign="center", size=2.5);

color("black") translate([0.6,0.5,16.5]) rotate([90,0,90]) text("µc³", halign="center", size=3, font="Droid Serif:style=Regular");

color ("yellow") translate([0,-10,20])  rotate([90,0,90]) scale([0.02,0.02,1]) linear_extrude(1) import("muccc-logo/logo.svg");
