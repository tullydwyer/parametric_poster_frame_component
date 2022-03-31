///
// Parameters
///

$fn=100;

// Porta 9.5mm Tasmanian Oak Dowel - 1.2m https://www.bunnings.com.au/porta-9-5mm-tasmanian-oak-dowel-1-2m_p0099360
// Plus 0.35 to make wood fit inside the 3d prints 
dowel_diameter = 9.5 + 0.35; 
dowel_depth = 40;
dowel_holder_depth = dowel_depth + 5; // + 5 mm
dowel_holder_diameter = dowel_diameter + 5; // + 5 mm
dowel_screw_size = 5; // M5

wire_hole_diameter = 3;

magnet_diameter = 8; // https://www.bunnings.com.au/everhang-12mm-rare-earth-disc-magnet-6-pack_p3690099
magnet_height = 3;
stem_length = magnet_diameter * 4;
thickness_around_magnet = 2; // 2mm
thickness_above_magnet = 1.5;

///
// Modules
///

// Dowel holder
module dowel_holder(dowel_holder_depth, dowel_holder_diameter, dowel_depth, dowel_diameter, dowel_screw_size) {
    difference() {
        cylinder (h = dowel_holder_depth, d=dowel_holder_diameter, center = false);
        cylinder (h = dowel_depth, d=dowel_diameter, center = false);
        rotate([0, 90, 0]) translate([-7, 0, 0]) cylinder (h = 40, d=dowel_screw_size, center = true); // TODO fix magic numbers
    }
};

module dowel_holder_hull(dowel_holder_depth, dowel_holder_diameter, dowel_depth, dowel_diameter) {
    difference() {
        cylinder (h = dowel_holder_depth, d=dowel_holder_diameter, center = false);
        cylinder (h = dowel_holder_depth-15, d=dowel_holder_diameter, center = false);
    }
};

// Magnet Holder
module magnet_holder(magnet_diameter, magnet_height, thickness_around_magnet, stem_length, dowel_holder_diameter) {
    thickness = magnet_height + thickness_above_magnet;
    outside_diameter = magnet_diameter + thickness_around_magnet;
    difference() {
        hull() {
            translate([0,stem_length,0]) cylinder (h = thickness, d=outside_diameter, center = true);
            cube([outside_diameter*0.5, 1, thickness], center = true);
        }
        // Inside magnet cutout
        translate([0,stem_length,0]) cylinder (h = magnet_height, d=magnet_diameter+1, center = true);
        // Outside magnet cutout
        translate([0,stem_length+outside_diameter/3,0]) cylinder (h = magnet_height, d=magnet_diameter+1, center = true);
        // Hole to push magnet out #TODO fix magic numbers
        translate([0,stem_length-(magnet_diameter/2),0]) rotate([120,0,0]) cylinder (h = 10, d=3, center = false);
        // cut the tip off for 3d printing #TODO fix magic numbers
        translate([0, stem_length+(magnet_diameter*0.75), -thickness_above_magnet/2]) cube ([outside_diameter, magnet_diameter, thickness], center = true);
    }
};

module magnet_holder_hull(magnet_diameter, magnet_height, thickness_around_magnet, stem_length, dowel_holder_diameter) {
    thickness = magnet_height + thickness_above_magnet;
    outside_diameter = magnet_diameter + thickness_around_magnet;
    cube([outside_diameter*0.5, 1, thickness], center = true);
};

///
// Main
///
module main() {
    // Rotate 180 to make it correct rotation for printing.
    rotate([180,0,0]) {
        // offset to make the bottom flat
        magnet_translate = [-15, 15, 5.18]; // TODO make z calculated
        magnet_rotate = [0,0,45];

        dowel_1_translate = [dowel_holder_depth,0,0];
        dowel_1_rotate = [270,0,90];

        dowel_2_translate = [0,-dowel_holder_depth,0];
        dowel_2_rotate = [270,0,0];

        difference() {
            union(){
                translate(magnet_translate) rotate(magnet_rotate) magnet_holder(magnet_diameter, magnet_height, thickness_around_magnet, stem_length, dowel_holder_diameter);
                // x
                translate(dowel_1_translate) rotate(dowel_1_rotate) dowel_holder(dowel_holder_depth, dowel_holder_diameter, dowel_depth, dowel_diameter, dowel_screw_size);
                // //middle
                // translate(dowel_3_translate) rotate(dowel_3_rotate) dowel_holder(dowel_holder_depth, dowel_holder_diameter, dowel_depth, dowel_diameter, dowel_screw_size);
                // y
                translate(dowel_2_translate) rotate(dowel_2_rotate) dowel_holder(dowel_holder_depth, dowel_holder_diameter, dowel_depth, dowel_diameter, dowel_screw_size);
                
                // Hull to join the 3 objects
                hull() {
                    translate(magnet_translate) rotate(magnet_rotate) magnet_holder_hull(magnet_diameter, magnet_height, thickness_around_magnet, stem_length, dowel_holder_diameter);
                    translate(dowel_1_translate) rotate(dowel_1_rotate) dowel_holder_hull(dowel_holder_depth, dowel_holder_diameter, dowel_depth, dowel_diameter);
                    // translate(dowel_3_translate) rotate(dowel_3_rotate) dowel_holder_hull(dowel_holder_depth, dowel_holder_diameter, dowel_depth, dowel_diameter);
                    translate(dowel_2_translate) rotate(dowel_2_rotate) dowel_holder_hull(dowel_holder_depth, dowel_holder_diameter, dowel_depth, dowel_diameter);
                }
            }
            // Cut out hole for wire
            // Move hold to centre
            translate([-5,0,0]) {
                // Rotate and cut through middle
                rotate([90,0,135]) cylinder (h = 100, d=wire_hole_diameter, center = true);
            }
        }
    }
}

///
// Render
///
main();
// magnet_holder(magnet_diameter, magnet_height, thickness_around_magnet, stem_length, dowel_holder_diameter);