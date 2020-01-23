/* [General] */
eps=0.1;
$fn=32;

/* [Head] */
head_type = "square"; //["square","printable","rounded"]

head_x = 20;
head_y = 3;
head_z = 20;

head_hole_d = 5;

/* [Blade] */

//height of the blade
blade_oh = 20;

//Outer diameter of the blade
blade_od = 8; //[2:0.1:20]

blade_sides = 6; //[3:64]

blade_ih = 10;

//Inner diameter of the blade
blade_id = 4; //[0:0.1:20]

/* [Blade - Pins] */
has_pins = false;
blade_pin_d = 2; //[0:0.1:5]
blade_pin_offset = 1; //[-5:0.1:5]
blade_pin_code = [0, 8, 3, 3, 1, 8, 1, 6];
blade_pin_h_mult = 0.333;
blade_pin_count = len(blade_pin_code);

/* [Blade - Nose] */
has_nose = false;
nose_x = 1.2;
nose_y = 1.2;
nose_z = 3;

module key(){
    translate([0,0,blade_oh]) {
        if (head_type=="square") head();
        if (head_type=="printable") head_printable();
        if (head_type=="rounded") head_rounded();
    }
    blade();
}

module head(){
    difference(){
        //body
        translate([0,0,head_z/2])
        cube([head_x,head_y,head_z], center=true);
        
        //hole
        translate([0,0,head_z-head_hole_d]) 
        rotate([90,0,0]) 
        cylinder(d=head_hole_d,h=head_y+eps,center=true);
    }
    
    //join to blade
    cylinder(d1=blade_od, d2=head_y, h=head_z/4, $fn=blade_sides);
}

module head_rounded(){
    difference(){
        //body
        translate([0,0,head_z/2])
        hull()
        for(ix=[-1,1], iz=[-1,1]) 
            translate([ix*(head_x/2-head_y/2),0,iz*(head_z/2-head_y/2)]) 
            sphere(d=head_y, $fn=16);
        
        //hole
        translate([0,0,head_z-head_hole_d]) 
        rotate([90,0,0]) 
        cylinder(d=head_hole_d,h=head_y+eps,center=true);
    }
    
    //join to blade
    cylinder(d1=blade_od, d2=head_y, h=head_z/4, $fn=blade_sides);
}

module head_printable(){
    difference(){
        hull(){
            cylinder(d=blade_od, h=eps, $fn=blade_sides);
            translate([0,0,head_z-5]) cube([head_x,head_y,3],center=true);
            translate([0,0,head_z]) cube (head_y,center=true);
        }
     //hole
    translate([0,0,head_z-head_hole_d]) 
    rotate([90,0,0]) 
    cylinder(d=head_hole_d,h=head_y*2,center=true);
}
}
module blade(){
    assert(blade_od > blade_id, "Outer diameter of the blade must be bigger than inner diameter");
    
    difference(){
        //body
        cylinder(h=blade_oh, d=blade_od, $fn=blade_sides);
        
        //inner hole
        translate([0,0,-eps]) 
        cylinder(h=blade_ih, d=blade_id, $fn=blade_sides);
        
        //pins
        if (has_pins)
            for(i= [0:blade_pin_count-1]) 
            let(rz_step = 360/blade_pin_count, 
                az = i*rz_step, 
                hz = blade_pin_code[i]*blade_pin_h_mult) {
                    
                echo(i);
                echo(hz);
                rotate([0,0,az])
                translate([blade_od/2+blade_pin_offset,0,-eps]) 
                cylinder(d=blade_pin_d, h=hz);
            }
    }

    if (has_nose)
        translate([blade_od/2+nose_x/2-eps,0,nose_z/2]) 
        cube([nose_x,nose_y,nose_z], center=true);
}

key();