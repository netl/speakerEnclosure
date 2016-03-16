module putki(d,lenStraight,lenBend)
{
    r=d/2;
    lenR=d*PI/4;
    lenOffset=lenBend/(2*PI);
    echo("other end of pipe is at ", -lenOffset, 0, d);
    echo("length from bend to bend is ", lenStraight+r+lenOffset/2);
    
    translate([-lenOffset,-(lenStraight-lenR+r),r])  //move to origin
        union()
        {
            //main bend
            difference()
            {
                rotate_extrude()
                    translate([lenBend/(2*PI), 0, 0])
                        circle(r = r);
                translate([-(lenOffset+r),0,-r])
                    cube([2*(lenOffset+d),lenOffset*2,d]);
            }
            
            //mirrored part
            for(i = [1,-1])
                translate([-i*lenOffset,0,0])
                {
                    //straight piece
                    rotate([-90,0,0])
                        translate([0,0,-0.0005])
                        cylinder(lenStraight-lenR+.001,r,r);
                    
                    //bend and entrance/exit
                    translate([0,lenStraight-lenR,0])
                        rotate([0,i*90,0])
                        {
                            //corner
                            translate([-r,0,0])
                                intersection()
                                {
                                    rotate_extrude()
                                            translate([r+0.001, 0, 0])
                                                circle(r = r);
                                    translate([0,0,-r])
                                        cube(d);
                                }
                            //entrance/exit
                            translate([-(r-0.001),r,0])
                                rotate([0,-90,0])
                                    cylinder(100,r,r);
                        }
                }
        }
}