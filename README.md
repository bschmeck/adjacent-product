# Find adjacent numbers with the highest product from a string of N numbers

## Finding adjacent numbers

We use the WindowGenerator class to yield each "window" of adjacent numbers to a given block.  There are 4 different ways of generating windows:

### Clone

Use a circular buffer: store the previous 3 numbers, append the 4th, yield a clone of the buffer, then remove the element at index 0.

### New Array

Use a circular buffer: store the previous 3 numbers, append the 4th, yield a new Array created from the buffer, then remove the element at index 0.

### Concatenation

Use a circular buffer: store the previous 3 numbers, yield the concatenation of that buffer with the 4th element, then append the element to the buffer and remove the element at index 0.

### Slice

Use `Array#slice` to yield window sized arrays.

### Performance

Even though slice (presumably) has to walk the array to yield each window, it still outperforms creating a new object each time through.

Results of generating 4 element windows from a 1M element array:

```
                user     system      total        real
clone       0.520000   0.000000   0.520000 (  0.524126)
new_array   0.500000   0.000000   0.500000 (  0.494841)
concat      0.380000   0.000000   0.380000 (  0.376844)
slice       0.160000   0.000000   0.160000 (  0.159733)
```
