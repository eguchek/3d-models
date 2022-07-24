$fn = 200;

length = 51;
width = 27.8;
base_height = 30;
top_height = 10;
border = 2;

hole_d = 5.5;
hole_h = 10;

support_base_d = 3.4;
support_top_d = 3;
support_h = 10;

support_offset = 2.1;

module Support(base_d, top_d, h) {
    base_r = base_d / 2;
    base_top_r_diff = base_r - (top_d / 2);
    cylinder_angel = atan(h / base_top_r_diff);
    cylinder_height = tan(cylinder_angel) * base_r;

    difference() {
        cylinder(cylinder_height, base_r, 0);
        translate([0, 0, cylinder_height / 2 + h]) {
            cube([base_d, base_d, cylinder_height], center = true);
        }
    }

}

module Hole(d, h, fill = true) {
    translate([0, border / 2, d / 2 - h]) {
        rotate(90, [1, 0, 0]) {
            if (fill) {
                union() {
                    translate([0, (h - d / 2) / 2, 0]) cube([d, h - d / 2, border], center = true);
                    cylinder(h = border, d = hole_d, center = true);
                }
            } else {
                difference() {
                    translate([0, (h - d / 2) / 2, 0]) cube([d, h - d / 2, border], center = true);
                    cylinder(h = border, d = hole_d, center = true);
                }                
            }
        }
    }
}

module Base(w, l, h, border) {
    difference() {
        cube([w + border * 4, l + border * 4, h]);
        translate([border, border, 2]) cube([w + border * 2, l + border * 2, h]);
        translate([(w + border * 4) / 2, 0, h]) Hole(hole_d, hole_h, true);
    }
    
    translate([border * 2 + support_offset, border * 2 + support_offset, 2]) {
        Support(support_base_d, support_top_d, support_h);
    }
    
    translate([border * 2 - support_offset + w, border * 2 + support_offset, 2]) {
        Support(support_base_d, support_top_d, support_h);
    }
    
    translate([border * 2 + support_offset, border * 2 - support_offset + l, 2]) {
        Support(support_base_d, support_top_d, support_h);
    }
    
    translate([border * 2 - support_offset + w, border * 2 - support_offset + l, 2]) {
        Support(support_base_d, support_top_d, support_h);
    }    
}

module Top(w, l, border) {
    cube([w + border * 4, l + border * 4, border]);
    difference() {
        translate([border, border, border]) cube([w + border * 2, l + border * 2, border * 2]);
        translate([border * 2, border * 2, border]) cube([w, l, border * 2]);
    }
    translate([(w + border * 4) / 2, 0, border]) rotate(180, [0, 1, 0]) Hole(hole_d, hole_h, false);
}

Base(width, length, base_height, border);
translate([0, -(length + border * 4 + 10), 0]) Top(width, length, border);
