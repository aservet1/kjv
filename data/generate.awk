BEGIN {
    #  $1 Book name
    #  $2 Book abbreviation
    #  $3 Book number
    #  $4 Chapter number
    #  $5 Verse number
    #  $6 Verse
    FS = "\t"

    print "/* This file is automatically generated. DO NOT EDIT. */"
    print ""
    print "#include \"bible_data.h\""
    print ""
    print "bible_verse bible_verses[] = {"

    book_count = 0
}

{
    gsub(/"/,"\\\"",$6)
    printf("    {%d, %d, %d, \"%s\"},\n", $3, $4, $5, $6)
    if (!($3 in book_names)) {
        book_names[$3] = $1
        book_abbrs[$3] = $2
        book_count++
    }
}

END {
    print "};"
    print ""
    printf("int bible_verses_length = %d;\n", NR)
    print ""

    print "bible_book bible_books[] = {"
    for (i = 1; i <= book_count; i++) {
        printf("    {%d, \"%s\", \"%s\"},\n", i, book_names[i], book_abbrs[i])
    }
    print "};"

    print ""
    printf("int bible_books_length = %d;\n", book_count)
}
