include <putkihelvetti.scad>

fast = false;
$fn = fast ? 4 : 64;

depth=26;
width=90;
height=135;

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
                            circle(4);
        //backlplate with rounded edges
        difference()
        {
            minkowski()
            {
                sphere(4);
                cube([width,height,2]);
            }
            translate([-4,-4,0])
                cube([width+8,height+8,6]);
        }
        
        //edges for mounting
        for(x=[0,width-5])
                for(y=[0,height-5])
                    translate([x,y,depth])
                    cube([5,5,2]);
    }
    
    if(!fast)
        translate([90-14-(90-14-71.9577)/2,(90-14-71.9577)/2+14,0.5])
            rotate([0,0,-90])
                putki(25,50,100);
    
    //cut out top half of reflex tube
     translate([0,0,12.5])
        cube([width,65,25/2+1]);
    
    //additional space for stuff
    translate([0,65,0])
        cube([width,70,20]);
}