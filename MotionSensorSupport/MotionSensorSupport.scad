$fn = 200;

nest_w = 35.9;
nest_l = 9.2;
nest_h = 5.5;
nest_border = 2;
nest_support_h = 12.4;
nest_walls_h = 15;

base_w = 52;
base_l = 68;
base_h = 39;
base_podium_h = 15;


module Nest() {
    full_nest_height = nest_walls_h + nest_support_h;
    
    difference() {
        translate([0, 0, full_nest_height / 2]) 
            cube([nest_w + nest_border * 2, nest_l + nest_border * 2, full_nest_height], center = true);    
        translate([0, 0, nest_h / 2 + nest_support_h]) 
            cube([nest_w, nest_l, nest_h], center = true);

        translate([0, 0, nest_h + nest_walls_h / 2 + nest_support_h])
            cube([nest_w, nest_l + nest_border + 2, nest_walls_h], center = true);
    }
}

module Base() {

    difference() {
        translate([- base_w / 2, 0 ,0]) cube([base_w, base_l, base_h]);
        translate([-base_w / 2, base_l / 2 + nest_l + nest_border * 2 + base_podium_h / 2, base_h]) 
            rotate(90, [0, 1, 0]) 
                cylinder(h = base_w, d = base_l + base_podium_h);
    }
}

Base();
translate([0, (nest_l + nest_border * 2) / 2 - 0.0001, base_h]) Nest();
