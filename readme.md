**Classification of different stages of cancer using OTU data**

**Objective:**
The objective of the dataset is to classify different stages of cancer based on certain diagnostic measurements. Raw sequencing data for the analysis was obtained from the publicly available 16S rRNA sequencing analysis dataset from NCBI - SRA(National center of Biotechnology Information - Sequence read archive).

**Dataset:**
The dataset has total 183 observations and 1141 predictors. We have one target variable which tells us the stage of cancer(1, 2, 3, 4, not). The data used in this classification analysis is OTU (operational taxonomic unit) relative-abundance matrix prepared by a Ph.d. Student Vaidehi Pusadkar(https://www.linkedin.com/in/vaidehi-pusadkar-497462114/) from the microbiome study based different stages of cancer.

**Procedure:**
I have designed a fully connected neural network to classify different stages of cancer using tidymodels, keras, tensorflow library in Rstudio. 

**Conclusion:**
The model has achieved overall accuracy of 36%. However, it is found performs better at classifying stage 4 from all other stages. The stage 1 and 2 have somewhat similar OTUs and it makes our model difficult to classify the stages 1 and 2. 

We have a small sub-set of data. We can make use of random forest algorithm and apply feature engineering(PCA) in order to improve the performance of our model. Also, we can use k-fold cross validation in order to have less biased model.
