# tested in python 2.7.2
# works for KiCAD 5978 by parsing output of this script into a xyz.kicad_pcb at the right place

import sys, os
import shutil
import math

#              0        1          2      3      4        5    6
LIST_elmt = ["  ("," (start ",") (end ",") "," (layer ",") ","))"]
#LIST_elmt = ["  (gr_line (start 131.571908 182.314571) (end 112.874456 120.68499) (angle 90) (layer Dwgs.User) (width 0.1))"]
#LIST_elmt = ["  (segment (start 118.7 106.7) (end 119.4 106.7) (width 0.25) (layer B.Cu) (net 0))"]
DICT_elmt = {"seg" : ["segment", "(width ", "(net "], # this works for Copper only
             "arc" : ["gr_arc", "(angle ", "(width "], # those work on all Non-Copper layers
             "lne" : ["gr_line", "(angle ", "(width "],
             }
DICT_lyr = { "dwg" : "Dwgs.User",
             "cmt" : "Cmts.User",
             "cut" : "Edge.Cuts",
             "fcu" : "F.Cu",
             "bcu" : "B.Cu",
             }

def FNC_string (element,
                STR_start, #1
                STR_end, #2
                Angle, #4
                layer, #5
                width,
                ):
    STR_line = ""
    """
                      0          1         2    3          4           5
    LIST_elmt = ["  ("," (start ",") (end ",") "," (layer ",") (width ","))"]
    """
    for i in range(len(LIST_elmt)):
        STR_line += LIST_elmt[i]
        if i == 0:
            STR_line += DICT_elmt[element][0]
        if i == 1:
            STR_line += STR_start
        if i == 2:
            STR_line += STR_end
        if i == 3:
            if element == "seg":
                STR_line += DICT_elmt[element][1]
                STR_angle = "{:.1f}".format(width)
            else:
                STR_line += DICT_elmt[element][1]
                if element == "lne":
                    STR_angle = "90"
                else:
                    STR_angle = str(Angle)
            STR_line += STR_angle + ")"
        if i == 4:
            STR_line += DICT_lyr[layer]
        if i == 5:
            if element == "seg":
                STR_line += DICT_elmt[element][2]
                STR_line += str(Angle)
            else:
                STR_line += DICT_elmt[element][2]
                STR_line += "{:.2f}".format(width)
    STR_line += "\n"
    return STR_line

def FNC_arc (cntr, # (x,y)
             radius,
             sides,
             startangle,
             angle,
             tw, # track width
             layer,
             net,
             ):

    STR_data = ""
    baseX = cntr[0]
    baseY = cntr[1]
    sideangle = angle / sides

    for i in range(sides):
        startX = baseX + radius * math.sin(math.radians(sideangle*(i+0.5) + startangle))
        startY = baseY + radius * math.cos(math.radians(sideangle*(i+0.5) + startangle))
        endX = baseX + radius * math.sin(math.radians(sideangle*(i+1.5) + startangle))
        endY = baseY + radius * math.cos(math.radians(sideangle*(i+1.5) + startangle))
        STR_data += FNC_string ("seg", #type of line, change if not used for copper layer
                                "{:.6f}".format(startX) + " " + "{:.6f}".format(startY), # start point
                                "{:.6f}".format(endX) + " " + "{:.6f}".format(endY), # end point
                                net, # angle or net value
                                layer, # layer on pcb
                                tw, # track width
                                )
    return STR_data


if __name__ == '__main__':

    #adjust parameters to your liking here
    Center = [105.0,105.0] # x/y coordinates of the centre of the circle/arc
    Radius = 2.5 # mm
    Sides = 16
    StartAngle = 0 # degrees
    Angle = 359 # degrees
    TrackWidth = 1.4
    Layer = "fcu"
    Net = "0"

    print FNC_arc (Center,
                    Radius,
                    Sides,
                    StartAngle,
                    Angle,
                    TrackWidth,
                    Layer,
                    Net,
                    )
