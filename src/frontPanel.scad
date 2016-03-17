height=135; //height of speaker
width=90;   //width of speaker
depth=10;   //how much does the front panel add depth
speakerWidthOffset=width/2;    //horizonal position of speaker
speakerHeightOffset=51; //vertical position of speaker
speakerHeight=5.6;  //depth of speaker from front panel
speakerRadius=90/2; //radius of speaker
gridIndex=(width+8)/3;  //density of mesh
walls=4;    //the thickness of the surrounding walls
overlap=10; //how much to go over the enclosure
part="all"; //what to print

//do not touch
radius=sqrt(pow(speakerWidthOffset,2)+pow(height-speakerHeightOffset,2)); //height/width radius of curve
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
            translate([-width+speakerWidthOffset,-height+speakerHeightOffset,-overlap])
                minkowski()
                    {
                        cube([width,height,depth]);
                        cylinder(depth+overlap,walls,walls);
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
                translate([-speakerWidthOffset,-height+speakerHeightOffset,-overlap+walls])
                    difference()
                    {
                        minkowski()
                        {
                            cube([width,height,depth+overlap]);
                            sphere(walls);
                        }
                        translate([walls,walls,-walls])
                        minkowski()
                        {
                            cube([width-walls*2,height-walls*2,depth+overlap]);
                            cylinder(depth+overlap,walls,walls);
                        }
                    }
            }        
        }
        //space for speaker element
        cylinder(speakerHeight,r=speakerRadius);
    }
    if(part=="frame")
        difference()
        {
            translate([-width+speakerWidthOffset,-height+speakerHeightOffset,0])
                cube([width,height,depth]);
            translate([-speakerRadius,-speakerRadius,speakerHeight])
                cube([speakerRadius*2,speakerRadius*2,depth-speakerHeight]);
        }
    if(part=="speaker")
        translate([-speakerRadius,-speakerRadius,speakerHeight])
            cube([speakerRadius*2,speakerRadius*2,depth-speakerHeight]);
    if(part=="overlap")
        translate([-width+speakerWidthOffset,-height+speakerHeightOffset,-overlap])
            cube([width,height,overlap]);
}