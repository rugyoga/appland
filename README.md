Some utilities to shrink (and expand) Appland data files

declutter.rb -- omits getX, setX and isX methiods from the 'events' stream.
compress.rb -- uses a simple dictionary strinbg com,pression algorithm to enure
that strings only appear once (in teh dictionary) and everywhere else are referred
to by their index into the dictiopnary array.
decompress.rb -- reverses the compression of compress.rb

Performance

-rw-r--r-- 1 guy guy 550694220 Dec 13 18:52 results.json
-rw-r--r-- 1 guy guy 229208438 Dec 14 23:36 results_decluttered.json
-rw-r--r-- 1 guy guy  73238416 Dec 14 23:37 results_compressed.json
-rw-r--r-- 1 guy guy   4914232 Dec 14 23:37 results_compressed.json.gz

Combine declutter, compress and gzip to get 100x compression!