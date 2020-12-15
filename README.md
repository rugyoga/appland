# Some utilities to shrink (and expand) Appland data files

* declutter.rb

  omits getX, setX and isX methiods from the 'events' stream.

* compress.rb

  uses a simple dictionary string compression algorithm to ensure
  that strings only appear once (in the dictionary) and everywhere else are referred
  to by their index into the dictionary array.

* decompress.rb

  reverses the compression of compress.rb

# Algorithm

The declutter.rb removes (get|set|is) events.
The (de)compress.rb implements lossless string compression.
Looking at the data I was struck by how often I saw long strings repeated.
Not only do they take up space but for any other transformation, the string comparisons would be expensive.
So I wondered: how hard would it be to implement a simple dictionary compression for strings alone?
Not too hard. The major subtlety is when you are decompressing and you come across a numeric;
how do you know if it really is a numeric or a compressed string?
It's a compressed string if the field (path) is stored in dictionary['fields'].
So as the (de)compressor recursively traverses the object, it maintains
a path list that's the list of fields dereferenced to get to the current point.

# Performance

```
-rw-r--r-- 1 guy guy 550694220 Dec 13 18:52 results.json
-rw-r--r-- 1 guy guy 229208438 Dec 14 23:36 results_decluttered.json
-rw-r--r-- 1 guy guy  73238416 Dec 14 23:37 results_compressed.json
-rw-r--r-- 1 guy guy   4914232 Dec 14 23:37 results_compressed.json.gz
```

Combine declutter, compress and gzip to get 100x compression!
