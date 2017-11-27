// based on Parametric and Customizable Project Enclosure by ffleurey is licensed under the Creative Commons - Attribution - Non-Commercial license. 
// https://www.thingiverse.com/thing:155001/

enclosure_inner_length = 71;
enclosure_inner_width = 36;
enclosure_inner_depth = 12;

enclosure_thickness = 2;

cover_thickness = 3;

part = "enclosure"; // [enclosure:Enclosure, cover:Cover, both:Enclosure and Cover]

print_part();

module print_part() {
	if (part == "enclosure" || part == "both") {
		box2(enclosure_inner_length,enclosure_inner_width,enclosure_inner_depth,enclosure_thickness,enclosure_thickness/2-0.10,cover_thickness);
	}
    if (part == "cover" || part == "both") {
		lid2(enclosure_inner_length,enclosure_inner_width,enclosure_inner_depth,enclosure_thickness,enclosure_thickness/2+0.10,cover_thickness);
	}
}

module bottom(in_x, in_y, in_z, shell) {
	hull() {
   	 	translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=shell, $fn=32);
		translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=shell, $fn=32);
		translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=shell, $fn=32);
		translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=shell, $fn=32);
	}
}

module sides(in_x, in_y, in_z, shell) {
    // screwholes
    translate([-14.65,-11.7,shell]) 
    difference() {
      cylinder(r=4,h=5, $fn=32);
      cylinder(r=1,h=5, $fn=32);
    };
    
    translate([-30.95,13.2,shell]) 
    difference() {
      cylinder(r=4,h=5, $fn=32);
      cylinder(r=1,h=5, $fn=32);
    };
    
    translate([28.75,12.65,shell]) 
    difference() {
      cylinder(r=4,h=5, $fn=32);
      cylinder(r=1,h=5, $fn=32);
    };
    
translate([0,0,shell]) 
difference(){
    difference() {
        hull() {
            translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=in_z, $fn=32);
            translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=in_z, $fn=32);
            translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=in_z, $fn=32);
            translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=in_z, $fn=32);
        }
        hull() {
            translate([-in_x/2+shell, -in_y/2+shell, in_z/2]) cube([shell*2, shell*2, in_z], true);
            translate([+in_x/2-shell, -in_y/2+shell, in_z/2]) cube([shell*2, shell*2, in_z],true);
            translate([+in_x/2-shell, in_y/2-shell, in_z/2]) cube([shell*2, shell*2, in_z],true);
            translate([-in_x/2+shell, in_y/2-shell, in_z/2]) cube([shell*2, shell*2, in_z],true);
        }
    }
    union() {
        translate([25.7,-in_y/2-shell,6.8]) cube([5,3,4]);  // button 1
        translate([8.32,-in_y/2-shell,6.8]) cube([5,3,4]);// button 2
        translate([-9.3,-in_y/2-shell,6.8]) cube([5,3,4]);  // button 3
        translate([-26.3,-in_y/2-shell,6.8]) cube([5,3,4]); // button 4
        translate([in_x/2-shell,-12.5,6.8]) cube([4,5,4]);// button 5
        translate([in_x/2-shell,-4.23,6]) cube([4,12.8,2.5]); // microsd
        translate([-5.2,in_y/2,6.5]) cube([6,3,2.3]);           // pwr switch
        translate([-17.72,in_y/2,6.5]) cube([6,3,2.3]);         // rf switch
        translate([-in_x/2-shell,2.8,6.2]) cube([4,8.2,4.4]);   // usb port
    }
}
}

module lid_top_lip2(in_x, in_y, in_z, shell, top_lip, top_thickness) {
	cxm = -in_x/2 - (shell-top_lip);
	cxp = in_x/2 + (shell-top_lip);
	cym = -in_y/2 - (shell-top_lip);
	cyp = in_y/2 + (shell-top_lip);

	translate([0,0,shell+in_z])

    difference() {

        hull() {
            translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=top_thickness, $fn=32);
            translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=top_thickness, $fn=32);
            translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=top_thickness, $fn=32);
            translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=top_thickness, $fn=32);
        }
	
        translate([0, 0, -1]) linear_extrude(height = top_thickness + 2) polygon(points = [
            [cxm+2.5, cym],
            [cxm, cym+2.5],
            [cxm, cyp-2.5],
            [cxm+2.5, cyp],
            [cxp-2.5, cyp],
            [cxp, cyp-2.5],
            [cxp, cym+2.5],
            [cxp-2.5, cym]]);
    }
}

module lid2(in_x, in_y, in_z, shell, top_lip, top_thickness) {
	cxm = -in_x/2 - (shell-top_lip);
	cxp = in_x/2 + (shell-top_lip);
	cym = -in_y/2 - (shell-top_lip);
	cyp = in_y/2 + (shell-top_lip);	

    difference() {
        translate([0, 0, in_z+shell]) linear_extrude(height = top_thickness ) polygon(points = [
            [cxm+5, cym],
            [cxm, cym+5],
            [cxm, cyp-5],
            [cxm+5, cyp],
            [cxp-5, cyp],
            [cxp, cyp-5],
            [cxp, cym+5],
            [cxp-5, cym]]);
    }
}

module box2(in_x, in_y, in_z, shell, top_lip, top_thickness) {
	bottom(in_x, in_y, in_z, shell);
	difference() {
		sides(in_x, in_y, in_z, shell);
	}
    lid_top_lip2(in_x, in_y, in_z, shell, top_lip, top_thickness);
}
