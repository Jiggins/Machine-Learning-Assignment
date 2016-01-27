# Matrix Completion and Rank Learning

## Data

In the directory `data` associated with this project are three sources of data.

- The most important of these is the file `sparse-rating-matrix` which contains
    ratings (on a scale of 1 to 10, with 10 being best) of 32 blurbs, by
    various raters. Each rater rated only a subset of the blurbs; or phrased
    another way, each blurb was rated by only a subset of the raters. We can
    consider this a matrix of ratings whose columns are indexed by blurb and
    whose rows are indexed by rater. Most of the entries, which corresponding
    to ratings, are missing. The data in this file represents the matrix by
    listing the non-missing entries by putting three pieces of information on
    each line: rater blurb rating. The raters and blurbs are given by
    eight-character cryptographic codes. (You can turn the codes into
    consecutive numbers for processing; I did not do this because I did not
    want to bias your results by the way the raters or blurbs were ordered.)

- The file rating-ranks gives purported ground truth ratings of all the blurbs,
    ranked, with a ranking of 1 being the best.

- The blurbs directory contains the actual blurbs.

## Task

Your task is to do something with this data, and explain what you did. Here is
a list of possible somethings, starting from less ambitious and progressing to
more ambitious. Although you are not constrained to do something on this list,
you might want to reality-check off-list ideas for non-silliness.

- Sparse Matrix Completion: using only the `sparse-rating-matrix,` use some
    algorithm to do matrix completion (e.g., Nonnegative Matrix Factorization
    aka NMF, tweaked to ignore the missing entries in the update equations, or
    some other algorithm of your choice). Using this complete matrix, check how
    well it matches the `rating-ranks` ground truth, using some way of going
    from the complete matrix to ranks (e.g., simply averaging across rows to
    get a rating for each blurb and then rank ordering them and then measuring
    the difference between that ranking and the ground truth ranking by making
    a scatterplot). An even simpler method here would be to do cross
    validation: leave out one of the known entries from the matrix, do matrix
    completion, and then check the difference between the estimated value and
    the true value for that entry, and do this for all known entries on the
    matrix. Then note which entries in the matrix seem suspect, or plot the
    data in some fashion that facilitates visualization.

- Do matrix completion as above, average across rows to get a score for each
    blurb (or just average known entries and forget the matrix completion) then
    try to learn a function that takes the text of each blurb as input and has
    the estimated score as target output. This requires not just choosing
    a supervised learning method to learn this mapping, but also encoding the
    text of an blurb as a feature vector. You could use whatever features
    strike your fancy.

- Forget the ratings, just look at the blurbs, and do topic analysis to try to
    find structure in them. In the simplest case, this would mean making
    a matrix whose columns are blurbs, and whose rows are words, and whose
    entries are per-blurb word frequencies or simple 0 or 1 for present vs
    absent; and then doing NMF or some other decomposition on this matrix, and
    then looking for interesting structure in the result. (E.g., are the cancer
    blurbs given the same topic? The drug discovery ones? Etc.)
