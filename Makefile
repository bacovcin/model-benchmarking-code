rawdata = $(wildcard data/*/*.csv)
.PHONY : iris
processed-data/iris/iris-train1.csv processed-data/iris/iris-train2.csv processed-data/iris/iris-train3.csv processed-data/iris/iris-train4.csv processed-data/iris/iris-test1.csv processed-data/iris/iris-test2.csv processed-data/iris/iris-test3.csv processed-data/iris/iris-test4.csv processed-data/iris/iris-trainy.csv processed-data/iris/iris-testy.csv : iris
	
iris : data/iris/Iris.csv code/preprocessing.R code/preprocessing-iris.R
	Rscript code/preprocessing-iris.R

.PHONY:glass
processed-data/glass/glass-train1.csv processed-data/glass/glass-train2.csv processed-data/glass/glass-train3.csv processed-data/glass/glass-train4.csv processed-data/glass/glass-test1.csv processed-data/glass/glass-test2.csv processed-data/glass/glass-test3.csv processed-data/glass/glass-test4.csv processed-data/glass/glass-trainy.csv processed-data/glass/glass-testy.csv : glass

glass:data/glass/glass.csv code/preprocessing.R code/preprocessing-glass.R
	Rscript code/preprocessing-glass.R

.PHONY:noshow
processed-data/no-show/no-show-train1.csv processed-data/no-show/no-show-train2.csv processed-data/no-show/no-show-train3.csv processed-data/no-show/no-show-train4.csv processed-data/no-show/no-show-test1.csv processed-data/no-show/no-show-test2.csv processed-data/no-show/no-show-test3.csv processed-data/no-show/no-show-test4.csv processed-data/no-show/no-show-trainy.csv processed-data/no-show/no-show-testy.csv : 
noshow : data/no-show/No-show-Issue-Comma-300k.csv code/preprocessing.R code/preprocessing-no-show.R
	Rscript code/preprocessing-no-show.R

.PHONY:speeddate
processed-data/speeddate/speeddate-train1.csv processed-data/speeddate/speeddate-train2.csv processed-data/speeddate/speeddate-train3.csv processed-data/speeddate/speeddate-train4.csv processed-data/speeddate/speeddate-test1.csv processed-data/speeddate/speeddate-test2.csv processed-data/speeddate/speeddate-test3.csv processed-data/speeddate/speeddate-test4.csv processed-data/speeddate/speeddate-trainy.csv processed-data/speeddate/speeddate-testy.csv : speeddate
	
speeddate:data/speed-date/speed-date.csv code/preprocessing.R code/preprocessing-speeddate.R
	Rscript code/preprocessing-speeddate.R

.PHONY:housing
processed-data/housing/housing-train1.csv processed-data/housing/housing-train2.csv processed-data/housing/housing-train3.csv processed-data/housing/housing-train4.csv processed-data/housing/housing-test1.csv processed-data/housing/housing-test2.csv processed-data/housing/housing-test3.csv processed-data/housing/housing-test4.csv processed-data/housing/housing-trainy.csv processed-data/housing/housing-testy.csv : housing
	
housing:data/kc_house/kc_house_data.csv code/preprocessing.R code/preprocessing-housing.R
	Rscript code/preprocessing-housing.R

.PHONY:nyse
processed-data/nyse/nyse-train1.csv processed-data/nyse/nyse-train2.csv processed-data/nyse/nyse-train3.csv processed-data/nyse/nyse-train4.csv processed-data/nyse/nyse-test1.csv processed-data/nyse/nyse-test2.csv processed-data/nyse/nyse-test3.csv processed-data/nyse/nyse-test4.csv processed-data/nyse/nyse-trainy.csv processed-data/nyse/nyse-testy.csv : nyse
	
nyse:data/nyse/prices.csv data/nyse/securities.csv code/preprocessing.R code/preprocessing-nyse.R
	Rscript code/preprocessing-nyse.R

.PHONY : preprocess

preprocess : processed-data/iris/iris-train1.csv processed-data/iris/iris-train2.csv processed-data/iris/iris-train3.csv processed-data/iris/iris-train4.csv processed-data/iris/iris-test1.csv processed-data/iris/iris-test2.csv processed-data/iris/iris-test3.csv processed-data/iris/iris-test4.csv processed-data/iris/iris-trainy.csv processed-data/iris/iris-testy.csv processed-data/glass/glass-train1.csv processed-data/glass/glass-train2.csv processed-data/glass/glass-train3.csv processed-data/glass/glass-train4.csv processed-data/glass/glass-test1.csv processed-data/glass/glass-test2.csv processed-data/glass/glass-test3.csv processed-data/glass/glass-test4.csv processed-data/glass/glass-trainy.csv processed-data/glass/glass-testy.csv processed-data/no-show/no-show-train1.csv processed-data/no-show/no-show-train2.csv processed-data/no-show/no-show-train3.csv processed-data/no-show/no-show-train4.csv processed-data/no-show/no-show-test1.csv processed-data/no-show/no-show-test2.csv processed-data/no-show/no-show-test3.csv processed-data/no-show/no-show-test4.csv processed-data/no-show/no-show-trainy.csv processed-data/no-show/no-show-testy.csv processed-data/speeddate/speeddate-train1.csv processed-data/speeddate/speeddate-train2.csv processed-data/speeddate/speeddate-train3.csv processed-data/speeddate/speeddate-train4.csv processed-data/speeddate/speeddate-test1.csv processed-data/speeddate/speeddate-test2.csv processed-data/speeddate/speeddate-test3.csv processed-data/speeddate/speeddate-test4.csv processed-data/speeddate/speeddate-trainy.csv processed-data/speeddate/speeddate-testy.csv processed-data/housing/housing-train1.csv processed-data/housing/housing-train2.csv processed-data/housing/housing-train3.csv processed-data/housing/housing-train4.csv processed-data/housing/housing-test1.csv processed-data/housing/housing-test2.csv processed-data/housing/housing-test3.csv processed-data/housing/housing-test4.csv processed-data/housing/housing-trainy.csv processed-data/housing/housing-testy.csv processed-data/nyse/nyse-train1.csv processed-data/nyse/nyse-train2.csv processed-data/nyse/nyse-train3.csv processed-data/nyse/nyse-train4.csv processed-data/nyse/nyse-test1.csv processed-data/nyse/nyse-test2.csv processed-data/nyse/nyse-test3.csv processed-data/nyse/nyse-test4.csv processed-data/nyse/nyse-trainy.csv processed-data/nyse/nyse-testy.csv
