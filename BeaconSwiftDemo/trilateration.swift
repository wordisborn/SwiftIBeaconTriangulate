//
//  trilateration.swift
//  BeaconSwiftDemo
//
//  Created by Fried, Jason (NYC-EML) on 8/15/14.
//  Copyright (c) 2014 IPGMediaLab. All rights reserved.
//
import UIKit
import Foundation

import UIKit
import Foundation


class trilateration {

    //P1,P2,P3 is the point and 2-dimension vector

    var P1 = ["x": Double(2), "y": Double(0)]
    var P2 = ["x": Double(8), "y": Double(0)]
    var P3 = ["x": Double(8), "y": Double(10)]





    //this is the distance between all the points and the unknown point

    let DistA: Double = 5.831
    let DistB: Double = 5.831
    let DistC: Double = 5.831

    let coords = ["x","y"]

    // ex = (P2 - P1)/(numpy.linalg.norm(P2 - P1))
    var ex = ["x":Double(0),"y":Double(0)]
    var ey = ["x":Double(0),"y":Double(0)]
    var ez = ["x":Double(0),"y":Double(0),"z":Double(0)]

    var triPt = ["x": Double(0),"y": Double(0)]

    var temp: Double = 0.0
    var t1: Double = 0.0
    var t2: Double = 0.0
    var t3: Double = 0.0
    var t4: Double = 0.0
    var t: Double = 0.0
    var exx: Double = 0.0
    var eyy: Double = 0.0
    var ezx: Double = 0.0
    var ezy: Double = 0.0
    var ezz: Double = 0.0
    var ival: Double = 0.0

    var p3p1 = ["x":Double(0),"y":Double(0)]
    var p3p1i: Double = 0.0


    for coord in coords{
        //run against the x
        t1 = Double(P2[coord]!)
        t2 = Double(P1[coord]!)
        t = t1 - t2
        temp += (t*t)
    }



    for coord in coords {
        t1 = Double(P2[coord]!)
        t2 = Double(P1[coord]!)
        exx = (t1 - t2)/sqrt(temp)
        ex[coord] = (Double(exx))
    }

    // i = dot(ex, P3 - P1)
    //  = [[NSMutableArray alloc] initWithCapacity:0];
    for coord in coords {
        t1 = Double(P3[coord]!)
        t2 = Double(P1[coord]!)
        t3 = t1 - t2
        p3p1[coord] = (Double(t3))
    }


    for coord in coords{
        t1 = ex[coord]!
        t2 = p3p1[coord]!
        ival += (t1*t2)
    }

    // ey = (P3 - P1 - i*ex)/(numpy.linalg.norm(P3 - P1 - i*ex))
    //NSMutableArray *ey = [[NSMutableArray alloc] initWithCapacity:0];
    //double p3p1i = 0;
    //for (int  i = 0; i < [P3 count]; i++) {
    for coord in coords {
        t1 = Double(P3[coord]!)
        t2 = Double(P1[coord]!)
        t3 = Double(ex[coord]!) * ival
        t = t1 - t2 - t3
        p3p1i += (t*t)
    }


    for coord in coords {
        t1 = Double(P3[coord]!)
        t2 = Double(P1[coord]!)
        t3 = Double(ex[coord]!) * ival
        eyy = (t1 - t2 - t3)/sqrt(p3p1i);
        ey[coord] = (Double(eyy))
    }


    // ez = numpy.cross(ex,ey)
    // if 2-dimensional vector then ez = 0

    //if ([P1 count] !=3){

    ezx = 0
    ezy = 0
    ezz = 0

    //    }else{
    //    ezx = ([[ex objectAtIndex:1] doubleValue]*[[ey objectAtIndex:2]doubleValue]) - ([[ex objectAtIndex:2]doubleValue]*[[ey objectAtIndex:1]doubleValue]);
    //    ezy = ([[ex objectAtIndex:2] doubleValue]*[[ey objectAtIndex:0]doubleValue]) - ([[ex objectAtIndex:0]doubleValue]*[[ey objectAtIndex:2]doubleValue]);
    //    ezz = ([[ex objectAtIndex:0] doubleValue]*[[ey objectAtIndex:1]doubleValue]) - ([[ex objectAtIndex:1]doubleValue]*[[ey objectAtIndex:0]doubleValue]);
    //
    //    }

    //    [ez addObject:[NSNumber numberWithDouble:ezx]];
    //    [ez addObject:[NSNumber numberWithDouble:ezy]];
    //    [ez addObject:[NSNumber numberWithDouble:ezz]];

    ez["x"] = 0
    ez["y"] = 0
    ez["z"] = 0



    // d = numpy.linalg.norm(P2 - P1)
    d: Double = sqrt(temp)

    // j = dot(ey, P3 - P1)
    jval: Double = 0
    for coord in coords {
        t1 = ey[coord]!
        t2 = p3p1[coord]!
        jval += (t1*t2)
    }

    // x = (pow(DistA,2) - pow(DistB,2) + pow(d,2))/(2*d)
    xval:Double = (pow(DistA,2) - pow(DistB,2) + pow(d,2))/(2*d)

    // y = ((pow(DistA,2) - pow(DistC,2) + pow(i,2) + pow(j,2))/(2*j)) - ((i/j)*x)
    yval:Double = ((pow(DistA,2) - pow(DistC,2) + pow(ival,2) + pow(jval,2))/(2*jval)) - ((ival/jval)*xval)

    // z = sqrt(pow(DistA,2) - pow(x,2) - pow(y,2))
    // if 2-dimensional vector then z = 0
    zval: Double = 0
    //    if ([P1 count] !=3){
    //    zval = 0;
    //    }else{
    //    zval = sqrt(pow(DistA,2) - pow(xval,2) - pow(yval,2));
    //    }

    // triPt = P1 + x*ex + y*ey + z*ez
    //    var triPt  = [[NSMutableArray alloc] initWithCapacity:0];
    for coord in coords {
        t1 = Double(P1[coord]!)
        t2 = Double(ex[coord]!) * xval
        t3 = Double(ey[coord]!) * yval
        t4 = Double(ez[coord]!) * zval
        var triptx:Double = t1+t2+t3+t4
        triPt[coord] = triptx
    }
    return triPt

}
