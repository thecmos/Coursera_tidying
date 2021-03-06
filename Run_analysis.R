##Wearables computing tidy dataset code script
## Read train activities's id's records
y_train<-scan("y_train.txt",character(),quote="")
##Read train subjects' id's records
s_train<-scan("subject_train.txt",character(),quote="")
##Read the actual training results
xx_train<-read.table("X_train.txt", header = FALSE, sep = "", nrows=7352)
##Start binding train columns together with the objective of forming one training table. First, activity id's and actual train results
yxx_train<-cbind(y_train,xx_train)
##Then also subjects' id's
syxx_train<-cbind(s_train,yxx_train)
##Exactly the same process with the test data…
y_test<-scan("y_test.txt",character(),quote="")
s_test<-scan("subject_test.txt",character(),quote="")
xx_test<-read.table("X_test.txt", header = FALSE, sep = "", nrows=2947)
syxx_test<-cbind(s_test,y_test,xx_test)
##By reading the features file we import the names of the variables for the above two formed tables (train and test)
feat<-read.delim("features.txt",header=FALSE,sep="")
##We can now add the column names to the two avove formed tables (train and test). Feat table has two columns, the variables names are in the second column.
colnames(syxx_test)<-c("subject","activity",feat[,2])
colnames(syxx_train)<-c("subject","activity",feat[,2])
##Now we can bind these two tables, training and test related, in rows.
tot_syxx<-rbind(syxx_train,syxx_test)


##We are not finished binding and merging because I am going to read and bind to the above dataset the columns of what the authors call the inertial signals, although it seems that it would not really be necessary because there are no mean or sd calculated variables in those files and therefore nothing to extract. But let's do it for the sake of practicing and learning. There are quite a few files, tedious… First training associated files and then test.

sigt1<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", header = FALSE, sep = "", col.names= paste0("baxt",seq_len(128)))

sigt2<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", header = FALSE, sep = "", col.names= paste0("bayt",seq_len(128)))

sigt3<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", header = FALSE, sep = "", col.names= paste0("bazt",seq_len(128)))

sigt4<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt", header = FALSE, sep = "", col.names= paste0("bgxt",seq_len(128)))

sigt5<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt", header = FALSE, sep = "", col.names= paste0("bgyt",seq_len(128)))

sigt6<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt", header = FALSE, sep = "", col.names= paste0("bgzt",seq_len(128)))

sigt7<-read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", header = FALSE, sep = "", col.names= paste0("taxt",seq_len(128)))
sigt8<-read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", header = FALSE, sep = "", col.names= paste0("tayt",seq_len(128)))

sigt9<-read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", header = FALSE, sep = "", col.names= paste0("tazt",seq_len(128)))

##Now test inertial signals, same process…

sigp1<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", header = FALSE, sep = "", col.names= paste0("baxt",seq_len(128)))

sigp2<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", header = FALSE, sep = "", col.names= paste0("bayt",seq_len(128)))

sigp3<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", header = FALSE, sep = "", col.names= paste0("bazt",seq_len(128)))

sigp4<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt", header = FALSE, sep = "", col.names= paste0("bgxt",seq_len(128)))

sigp5<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt", header = FALSE, sep = "", col.names= paste0("bgyt",seq_len(128)))

sigp6<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt", header = FALSE, sep = "", col.names= paste0("bgzt",seq_len(128)))

sigp7<-read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", header = FALSE, sep = "", col.names= paste0("taxt",seq_len(128)))

sigp8<-read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", header = FALSE, sep = "", col.names= paste0("tayt",seq_len(128)))

sigp9<-read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", header = FALSE, sep = "", col.names= paste0("tazt",seq_len(128)))


##Now, bind all together the inertial signals for train and test in several steps, first by rows…
tot_bin1<-rbind(sigt1,sigp1)
tot_bin2<-rbind(sigt2,sigp2)
tot_bin3<-rbind(sigt3,sigp3)
tot_bin4<-rbind(sigt4,sigp4)
tot_bin5<-rbind(sigt5,sigp5)
tot_bin6<-rbind(sigt6,sigp6)
tot_bin7<-rbind(sigt7,sigp7)
tot_bin8<-rbind(sigt8,sigp8)
tot_bin9<-rbind(sigt9,sigp9)
##Then all sets as columns
tot_bin_all<-cbind(tot_bin1,tot_bin2,tot_bin3,tot_bin4,tot_bin5,tot_bin6,tot_bin7,tot_bin8,tot_bin9)
##And now we can bind to the main training and test table the inertial signals table…
tot_tot<-cbind(tot_syxx,tot_bin_all)
##Now let's include the names of the activities rather than having just an id number
act_nam<-read.delim("activity_labels.txt",header=FALSE,sep="")
colnames(act_nam)<-c("activity","activityname")
data_for_analysis<-merge(tot_tot,act_nam,all.x=TRUE)
##As requested, extract only variables of measn and std's. And obvilously the necessary columns of subjects, activity names…
data_ms<-data_for_analysis[,grep("activ|subje|mean|std",colnames(data_for_analysis))]
##Eliminate a few rare columns data I believe are not calculated means of a variable ("meanFreq")
des<-c(grep("freq",colnames(data_ms),ignore.case=TRUE))
data_ms_2<-data_ms[,-des]
##remove dashes from col names and rename the variables
b<- mapply(gsub,"-","",colnames(data_ms_2))
data_ms_2_col<-data_ms_2
colnames(data_ms_2_col)<-b
##Just to simplify the name of the dataset for further manipulation because it had become too long…
data_f1<-data_ms_2_col
##Convert values to numeric, because of the error messages I got when I tried to calculate means of columns
for(i in 1:nrow(data_f1)){
for(j in 3:(ncol(data_f1)-1)){
data_f2[i,j]<-as.numeric(data_f1[i,j])
}}
##Rename columns of data_f2, back to the cleaned original variable names stored for the first time in b
nombres<-c("activityname","subject",colnames(data_f1[,3:68]))
colnames(data_f2)<-nombres
##This is the tody dataset requested, and I export it as a csv file
write.csv(data_f2,"data_f2.csv")

##A little sample of the tidy dataset…
View(data_f2)



##Now the second part of the exercise…, Group
data_f3<-group_by(data_f2,activityname,subject)
##Summarize all to calculate the means
means_final<- summarise_all(data_f3,funs(mean))
##This was the second dataset requested, that I export as csv file
write.csv(means_final,"means_final.csv")
View(means_final)


## The following is extra:
##Means grouped by activity, all subjects collapsed
means_act_final<-summarize_all(group_by(select(data_f2,-subject),activityname),funs(mean))
View(means_act_final)


##Means by subject, all activities collpased
means_subj_final<-summarize_all(group_by(select(data_f2,-activityname),subject),funs(mean))
View(means_subj_final)
