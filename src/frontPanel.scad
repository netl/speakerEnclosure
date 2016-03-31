height=145; //height of speaker
width=98;   //width of speaker
depth=15;   //how much does the front panel add depth
speakerWidthOffset=width/2;    //horizonal position of speaker
speakerHeightOffset=57; //vertical position of speaker
speakerHeight=8;  //depth of speaker from front panel
speakerRadius=95/2; //radius of speaker
gridIndex=(width+8)/3;  //density of mesh
walls=4;    //the thickness of the surrounding walls
overhang=10; //how much to go over the enclosure
part="all"; //what to print

//do not touch
radius=sqrt(pow(speakerWidthOffset+walls,2)+pow(height-speakerHeightOffset+walls,2)); //height/width radius of curve
offSet=(pow(radius,2)-pow(depth,2))/(2*depth); //position of sphere
bigRadius=offSet+depth; //radius of sphere
$fn=64;

intersection()  //prepare for printing
{
    difference()    //add cutouts
    {
        intersection()  //generate main shape
        {
            //rounded shape
            translate([0,0,-offSet])
                sphere(bigRadius,$fn=200);
            //remove excess material
            translate([-width+speakerWidthOffset,-height+speakerHeightOffset,-overhang])
                minkowski()
                    {
                        cube([width,height,depth]);
                        cylinder(depth+overhang,walls,walls);
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
                                translate([a*gridIndex,b*gridIndex*0.575,0])
                                    if(!(a+b)%2)
                                        circle(gridIndex*0.57, $fn=6);
                    }
                //rounded borders
                translate([-speakerWidthOffset,-height+speakerHeightOffset,-overhang+walls])
                    difference()
                    {
                        minkowski()
                        {
                            cube([width,height,depth+overhang]);
                            sphere(walls);
                        }
                        translate([walls,walls,-walls])
                        minkowski()
                        {
                            cube([width-walls*2,height-walls*2,depth+overhang]);
                            cylinder(depth+overhang,walls,walls);
                        }
                    }
            }        
        }
        //space for speaker element
        cylinder(speakerHeight,r=speakerRadius);
    }
    if(part=="mesh")
        difference()
        {
            translate([-width+speakerWidthOffset-walls,-height+speakerHeightOffset-walls,0])
                cube([width+2*walls,height+2*walls,depth]);
            translate([0,0,speakerHeight])
                cylinder(depth-speakerHeight,r=speakerRadius*1.11);
        }
    if(part=="speaker")
        translate([0,-0,speakerHeight])
            cylinder(depth-speakerHeight,r=speakerRadius*1.1);
    if(part=="overhang")
        translate([-width+speakerWidthOffset-walls,-height+speakerHeightOffset-walls,-overhang])
            cube([width+2*walls,height+2*walls,overhang-0.0001]);
}