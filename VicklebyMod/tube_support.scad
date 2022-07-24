$fn = 200;

total_h = 95;
tube_d = 98;
top_ring_h = 5;
top_ring_external_r = 25.4 / 2;
top_ring_middle_r = 14 / 2;
top_ring_middle_h = 5.1 - 2.7;
top_ring_internal_r = 9.7 / 2;
top_shoulders_offset = 15;
shoulders_depth = 10;
hook_width = 6;
hook_height = 6;
hook_shift = 6;

module Sholders() {
    
    tube_r = tube_d / 2;
    offset_w = tube_r - (top_ring_external_r + top_shoulders_offset);
    triangle_angel = atan(total_h / offset_w);
    triangle_h = tan(triangle_angel) * tube_r;
    
    h1 = tan(triangle_angel) * ((top_ring_external_r) + top_shoulders_offset);
    h2 = tan(triangle_angel) * (top_ring_external_r);
    internal_triangle_offset_y =  - (h1 - h2);

    difference() {
        linear_extrude(shoulders_depth) Triangle(tube_d, triangle_h);
        HookHole();
        linear_extrude(shoulders_depth) translate([0, internal_triangle_offset_y, 0]) Triangle(tube_d, triangle_h);
        translate([0, total_h + top_ring_h + triangle_h / 2, 0]) cube([tube_d, triangle_h, tube_d], center = true);
    }    
}

module HookHole() {
    c = sqrt(pow(shoulders_depth / 2, 2) * 2);
    translate([-tube_d / 2, shoulders_depth / 2, shoulders_depth / 2 - c / 2])
        rotate(45, [1, 0, 0])
            cube([tube_d, shoulders_depth / 2, shoulders_depth / 2]);
}

module Triangle(base, height) {
    polygon([[-base / 2, 0], [0, height], [base / 2, 0]]);
}

module TopTor() {
    rotate(90, [1,0,0])  {
        difference() {
            cylinder(h = top_ring_h, r = top_ring_external_r + top_shoulders_offset);
            cylinder(h = top_ring_h, r = top_ring_internal_r + 0.5);
            translate([0, 0, top_ring_h - top_ring_middle_h]) cylinder(h = top_ring_middle_h, r = top_ring_middle_r);
        }
    }
}

translate([0, 0, - shoulders_depth / 2]) Sholders();
rotate(60, [0, 1, 0]) translate([0, 0, - shoulders_depth / 2]) Sholders();
rotate(120, [0, 1, 0]) translate([0, 0, - shoulders_depth / 2]) Sholders();

translate([0, total_h + top_ring_h]) TopTor();
