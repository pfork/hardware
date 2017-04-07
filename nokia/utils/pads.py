#!/usr/bin/env python

# run with
# python KiCAD_CopperArc.py | python pads.py
# and then duplicate as many times necessary and place the pads manually

import sys, re, math

# converts from tracks like
#   (segment (start 105.477022 107.454068) (end 106.361598 107.096676) (width 1.2) (layer F.Cu) (net 0))
# to pads like
# (pad BCO smd oval (at -15.3 23.77 90) (size 0.8128 0.4064) (layers F.Cu F.Paste F.Mask))

def distance(p0, p1):
    return math.sqrt((p0[0] - p1[0])**2 + (p0[1] - p1[1])**2)

def getangle(p1, p2):
    p=(p1[0]-p2[0], p1[1]-p2[1])
    return math.degrees(math.atan2(-p[1],p[0]))
    #return math.degrees(math.atan2(*p[::-1]))

regex = re.compile(r'start ([0-9.]+) ([0-9.]+)\) \(end ([0-9.]+) ([0-9.]+).*\(width ([0-9.]+)')
for line in sys.stdin:
    if not line.strip(): continue
    m=regex.search(line)
    start,end,width=((float(m.group(1)), float(m.group(2))),
                     (float(m.group(3)), float(m.group(4))),
                     float(m.group(5)))
    #print start, end
    center=((start[0]+end[0])/2,(start[1]+end[1])/2)
    length=distance(start,end)
    angle=(getangle(start,end))
    print ('(pad "" smd rect (at %.3f %.3f %.3f) (size %.3f %.3f) (layers B.Cu B.Mask))' %
           (center[0], center[1], angle, 1.2, width))
