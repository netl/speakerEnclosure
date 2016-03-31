include <reflexTube.scad>

fast = false;
$fn = fast ? 4 : 64;

depth=26;
width=90;
height=137;
walls=4;

part="walls";

intersection()
{
    difference()
    {
        union()
        {
            //rounded walls
            linear_extrude(depth)
                hull()
                    for(x=[0,width])
                        for(y=[0,height])
                            translate([x,y,0])
                                circle(walls);
            //backlplate with rounded edges
            difference()
            {
                minkowski()
                {
                    sphere(4);
                    cube([width,height,2]);
                }
                translate([-walls,-walls,0])
                    cube([width+2*walls,height+2*walls,6]);
            }
        }
        
        if(!fast)
            translate([15,15,0.5])
                rotate([0,0,-180])
                    putki(25,50,100);
                
        //additional space for stuff
        translate([65,0,0])
            cube([width-65,height,20]);
    }
    if(part=="plate")
            translate([-walls,-walls,-walls])
                cube([2*walls+width,2*walls+height,walls]);
    if(part=="walls")
        difference()
        {
            translate([-walls,-walls,0])
                cube([2*walls+width,2*walls+height,depth]);
            translate([0,0,12.5])
                cube([width,height,25/2+1]);
        }
    if(part=="reflex")
        translate([0,0,12.5])
            cube([65,height,25/2+1]);
}