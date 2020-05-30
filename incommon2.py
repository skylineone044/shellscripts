#!/usr/bin/env python3
"""the main logic of the shellscripts to compare the
common dependencies between a number of packages, outputted by pacman"""

import sys

def reader(deps):
    """reads in the inputted text and concers it to a list"""
    all_list = deps.split("---")
    app_sep_list = []
    for i in range(len(all_list)):
        if all_list[i] != "\n" or all_list[i] != "":
            app_sep_list.append(set(all_list[i].split("\n")))
    app_sep_list.pop()
    #print(app_sep_list)
    #print(app_sep_list)
    #masterlist = []
    #for i in range(len(app_sep_list)):
        #print("\n")
        #for j in range(len(app_sep_list[i])):
            #print(app_sep_list[i][j])
    return app_sep_list

def comparer(mainlist):
    """compares the lists to each other continnually shrinking the common area"""
    for i in range(len(mainlist)):
        mainlist[0] = mainlist[0].intersection(mainlist[i])
        #print(mainlist[0])
    incommon = list(mainlist[0])
    incommon.sort()
    output = ""
    for i in range(len(incommon)):
        output += f"{incommon[i]}\n"
    print(output)


def main(deps):
    """main duh"""
    #comparer(reader())
    mainlist = reader(deps)
    comparer(mainlist)

if __name__ == "__main__":
    main(sys.stdin.read())
