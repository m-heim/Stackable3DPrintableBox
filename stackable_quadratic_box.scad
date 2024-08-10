include <BOSL2-master/std.scad>

$fn = 64;
sides = [FWD+RIGHT,FWD+LEFT,BACK+LEFT, BACK+RIGHT];
bottom = [BOT+LEFT, BOT+RIGHT, BOT+BACK, BOT+FWD];
sides_and_bottom = [FWD+RIGHT,FWD+LEFT,BACK+LEFT, BACK+RIGHT, BOT+LEFT, BOT+RIGHT, BOT+BACK, BOT+FWD];
anchor_top = [0,0,-1];

module stackable_quadratic_box(a, height, stack_height, thickness, tolerance, round_distance) {
    lower_half_a_outer = a - tolerance * 2 - thickness * 2;
    lower_half_a_inner = a - tolerance * 2 - thickness * 4;
    union() {
        difference() {
            translate([0, 0, 0]) {
                cuboid([lower_half_a_outer, lower_half_a_outer, stack_height], rounding=round_distance, edges=sides, anchor=anchor_top);
            }
            translate([0, 0, thickness])
            cuboid([lower_half_a_inner, lower_half_a_inner, height], rounding=round_distance, edges=sides, anchor=anchor_top);
        }
        
        translate([0, 0, stack_height]) {
            union() {
                difference() {
                    union() {
                        translate([0, 0, round_distance])
                        cuboid([a, a, height - stack_height], rounding=round_distance, edges=sides, anchor=anchor_top);
                        translate([0, 0, 0])
                        prismoid(lower_half_a_outer, a, h = round_distance * 1, rounding=round_distance, anchor=anchor_top);
                    }
                    translate([0, 0, round_distance])
                    cuboid([a - thickness * 2, a - thickness * 2, height - stack_height], rounding=round_distance, edges=sides, anchor=anchor_top);
                    translate([0, 0, 0])
                    prismoid(lower_half_a_inner, a, h = round_distance, rounding=round_distance, anchor=anchor_top);
                    translate([0, 0, -3])
                    cuboid([lower_half_a_inner, lower_half_a_inner, height], rounding=round_distance, edges=sides, anchor=anchor_top);
                }
            }
        }
    }
}
stackable_quadratic_box(90, 70, 10, 0.8, 0.5, 1.1);