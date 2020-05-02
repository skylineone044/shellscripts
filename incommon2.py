#!/usr/bin/env python3

import sys

def reader(deps):
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
    for i in range(len(mainlist)):
        mainlist[0] = mainlist[0].intersection(mainlist[i])
        #print(mainlist[0])
    incommon = list(mainlist[0])
    output = ""
    for i in range(len(incommon)):
        output += f"{incommon[i]}\n"
    print(output)


def main(deps):
    #comparer(reader())
    mainlist = reader(deps)
    comparer(mainlist)

if __name__ == "__main__":
    main(sys.stdin.read())
