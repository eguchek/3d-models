
hook_side = 5 - 0.25;
hook_width = 18;
hook_plain_width = 6;
hook_plain_offset = 2.5;

hole_offset = sqrt(pow(hook_side * 2, 2) / 2);

difference() {
    cube([hook_side, hook_width, hook_side]);
    translate([0, hook_width - hook_plain_offset - hook_side, hole_offset]) 
        rotate (45, [0, 1, 0])
            cube([hook_side * 2, hook_plain_width, hook_side * 2]);
}