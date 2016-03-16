height=143;
width=98;
depth=10;
widthOffset=width/2;
heightOffset=43;
index=width/10;

radius=sqrt(pow(widthOffset,2)+pow(height-heightOffset,2));
offSet=(pow(radius,2)-pow(depth,2))/(2*depth);
bigRadius=offSet+depth;
$fn=100;

echo(offSet,bigRadius);

difference()
{
    intersection()
    {
        //rounded shape
        translate([0,0,-offSet])
            sphere(bigRadius);
        //remove excess material
        translate([-width+widthOffset+4,-height+heightOffset+4,0])
            minkowski()
                {
                    cube([width-8,height-8,depth]);
                    cylinder(depth,4,4);
                }
        union()
        {
            //grid
            linear_extrude(depth)
                difference()
                {
                    circle(radius);
                    for(a = [-4:4])
                        for(b = [-20:20])
                            translate([a*index,b*index*0.575,0])
                                if(!(a+b)%2)
                                    circle(index*0.57, $fn=6);
                }
                //rounded borders
                translate([-widthOffset+4,-height+heightOffset+4,0])
                difference()
                {
                    minkowski()
                    {
                        cube([width-8,height-8,depth]);
                        cylinder(depth,4,4);
                    }
                    translate([4,4,0])
                    minkowski()
                    {
                        cube([width-16,height-16,depth]);
                        cylinder(depth,4,4);
                    }
                }
        }        
    }
    //space for speaker element
    cylinder(5.6,85/2,85/2);
}