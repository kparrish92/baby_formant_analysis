
library(naivebayes)


set.seed(1)
cols <- 10 ; rows <- 100
M <- matrix(rnorm(rows * cols, 100, 15), nrow = rows, ncol = cols)
y <- factor(sample(paste0("class", LETTERS[1:2]), rows, TRUE, prob = c(0.3,0.7)))
colnames(M) <- paste0("V", seq_len(ncol(M)))


### Train the Gaussian Naive Bayes
gnb <- gaussian_naive_bayes(x = M, y = y)
summary(gnb)

# Classification
head(predict(gnb, newdata = M, type = "class")) # head(gnb %class% M)

# Posterior probabilities
head(predict(gnb, newdata = M, type = "prob")) # head(gnb %prob% M)

# Parameter estimates
coef(gnb)


### Sparse data: train the Gaussian Naive Bayes
library(Matrix)
M_sparse <- Matrix(M, sparse = TRUE)
class(M_sparse) # dgCMatrix

# Fit the model with sparse data
gnb_sparse <- gaussian_naive_bayes(M_sparse, y)

# Classification
head(predict(gnb_sparse, newdata = M_sparse, type = "class"))

# Posterior probabilities
head(predict(gnb_sparse, newdata = M_sparse, type = "prob"))

# Parameter estimates
coef(gnb_sparse)


### Equivalent calculation with general naive_bayes function.
### (no sparse data support by naive_bayes)

nb <- naive_bayes(M, y)
summary(nb)
head(predict(nb, type = "prob"))

# Obtain probability tables
tables(nb, which = "V1")
tables(gnb, which = "V1")

# Visualise class conditional Gaussian distributions
plot(nb, "V1", prob = "conditional")
plot(gnb, which = "V1", prob = "conditional")

# Check the equivalence of the class conditional distributions
all(get_cond_dist(nb) == get_cond_dist(gnb))
[Package naivebayes version 1.0.0 Index]