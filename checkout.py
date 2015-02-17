# -*- coding: utf-8 -*-


import re
import sys
import getopt


"""
this script uncomments outcommented lines between matching tags and
comments out uncommented lines between matching tags
example:
    (target = osx)

    # <§ begin osx §>
        # /usr/local/bin/python3
    # <§ end osx §>
    # <§ begin arch §>
        /usr/local/bin/python3
    # <§ end arch §>

    will become

    # <§ begin osx §>
        /usr/local/bin/python3
    # <§ end osx §>
    # <§ begin arch §>
        # /usr/local/bin/python3
    # <§ end arch §>
"""


def read_tag(line):
    """
    reads a single line of a textfile an search for template tags according to the schema:
        <§ begin mbp §>
        <§ end mbp §>
    where begin would be the control part and mbp would be the identifier
    string line: a single line of a text file
    string result: a dict with a control part and a identifier part or an empy dict if the line do not contain a template tag
    """
    pattern = re.compile(r"^.*<§\s(?P<control>begin|end)\s(?P<identifier>.*)\s§>.*$")

    match = re.search(pattern, line)
    result = {}
    if match:
        result["control"] = match.group("control")
        result["identifier"] = match.group("identifier")

    return result


def comment_line(line, comment_char):
    """
    comments out a single line in a textfile
    string line: the line
    string comment_char: the char initiating a comment
    string processed_line: the commented out line
    """
    # check if not already commented out
    regex_str = r"^\s+%s.*$" % comment_char
    pattern = re.compile(regex_str)
    match = re.search(pattern, line)
    if match:
        return line

    pattern = re.compile(r"(?P<whitespace>^\s*)(?P<code>.*$)")

    match = re.search(pattern, line)
    if match:
        processed_line = "%s%s %s" % (match.group("whitespace"), comment_char, match.group("code"))
    else:
        processed_line = "%s %s" % (comment_char, line)

    return processed_line


def uncomment_line(line, comment_char):
    """
    removes the char initiating a comment of a line in a textfile
    string line: the line
    string comment_char: the char initiating a comment
    string processed_line: the uncommented line
    """
    print "uncommend ----------------"
    # check für comment after whitespace
    pattern_string = "(?P<whitespace>^\s*)(?P<comment>%s)(?P<code>.*$)" % comment_char
    pattern = re.compile(pattern_string)
    match = re.search(pattern, line)

    if match:
        processed_line = "%s%s" % (match.group("whitespace"), match.group("code"))
    else:
        # check for comment at the beginning of the line
        pattern_string = "(?P<comment>^%s)(?P<code>.*$)" % comment_char
        pattern = re.compile(pattern_string)
        match = re.search(pattern, line)

        if match:
            processed_line = match.group("code")
            # recursively remove all comment_chars
            # return uncomment_line(processed_line, comment_char)
            # return processed_line
            # return uncomment_line(processed_line, comment_char)

        else:
            # line is not commented out
            return line

    # return processed_line
    return uncomment_line(processed_line, comment_char)


def process_file(file_in_name, file_out_name, template):
    """
    string file_in_name: the (file)name of the input file
    string file_out_name: the (file)name of the output file
    string template: the template tag identifier
    """
    lines_in = []
    lines_out = []
    with open(file_in_name) as file_in:
        lines_in = file_in.readlines()

    # flush the output file
    with open(file_out_name, "w+") as file_out:
        pass

    with open(file_out_name, "w") as file_out:
        mode = "normal"
        for counter, line_in in enumerate(lines_in):
            tag_in_line = False

            if read_tag(line_in):
                template_tag = read_tag(line_in)
                tag_in_line = True

                if template_tag["identifier"] != template:
                    if template_tag["control"] == "begin":
                        mode = "comment"
                        print "changed mode to comment"
                    elif template_tag["control"] == "end":
                        mode = "normal"
                        print "changed mode to normal"
                elif template_tag["identifier"] == template:
                    if template_tag["control"] == "begin":
                        mode = "uncomment"
                        print "changed mode to uncomment"
                    elif template_tag["control"] == "end":
                        mode = "normal"
                        print "changed mode to normal"

            if mode == "comment" and not tag_in_line:
                file_out.write("%s\n" % comment_line(line_in, "#"))
            elif mode == "uncomment" and not tag_in_line:
                file_out.write("%s\n" % uncomment_line(line_in, "#"))
            else:
                file_out.write(line_in)


def main(argv):
    inputfile = ""
    outputfile = ""
    identifier = ""
    try:
      opts, args = getopt.getopt(argv,"i:o:t:",["i=","o=","t="])
    except getopt.GetoptError:
        print "checkout.py -i <inputfile> -o <outputfile> -t <template>"
        sys.exit(2)
    for opt, arg in opts:
        if opt == "-h":
            print "checkout.py -i <inputfile> -o <outputfile> -t <template>"
            sys.exit()
        elif opt == "-i":
            inputfile = arg
        elif opt == "-o":
            outputfile = arg
        elif opt == "-t":
            template = arg

    if inputfile and outputfile and template:
        print "-i: %s" % inputfile
        print "-o: %s" % outputfile
        print "-t: %s" % template

        process_file(inputfile, outputfile, template)


if __name__ == "__main__":
    main(sys.argv[1:])
