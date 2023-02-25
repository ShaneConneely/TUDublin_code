library(csv)
library(tidyr)
library(stringr)
library(tibble)
library(dplyr)

data <- read.csv("work file.csv")


data <- tibble::rowid_to_column(data, "application_id")

head(data)

hold_party="party_"

#################
#################
#################
# breaking up parties into their components

#str_detect(data$party_1, '(Applicant)')


#text <- data$party_1[1]

#hold_party = "party_"

#which(colnames(data) == corner)
#data[which(colnames(data) == corner)]

unlist(gregexpr('(Applicant)', data$party_1))

party_kinds <- c('(Applicant)', 
                 '(Leave to Appeal Applicant)',
                 '(Applicant - Leav)',
                 '(Applicant -Devel)',
                 '(Applicant  for Development)',
                 '(Applicant - Consent)',
                 '(Applicant - Consen)',
                 '(Applicant - Leave)',
                 '(Applicant - Cons)',
                 '(Appellant)',
                 '(1st Party Appellant)', 
                 '(3rd Party Appellant)', 
                 '(Appellant/PresBody)',
                 '(Owner Occupier)', 
                 '(Owner/Occupier)',
                 '(Landowner)',
                 '(Prescribed Body)',
                 '(Prospective Applicant)',
                 '(Prosp. Applicant)',
                 '(Prospective Appl)',
                 '(Referrer)',
                 '(1st party Referrer)',
                 '(3rd party Referrer)',
                 '(Third Party)',
                 '(Requester)',
                 '(Reviewer)',
                 '(Invited S131)',
                 '(Invited S.131)',
                 '(Invited S132)',
                 '(Invited S.132)',
                 '(Planning Authority)',
                 '(Local authority)',
                 '(Planning Authority Referrer)',
                 '(Appellant/PresBod)',
                 '(Developer)',
                 'Dismissed')



clean_party_kinds <- c("Applicant", 
                       "Applicant",
                       "Applicant",
                       "Applicant",
                       "Applicant",
                       "Applicant",
                       "Applicant",
                       "Applicant",
                       "Applicant",
                       "Appellant",
                       "Appellant",
                       "Appellant", 
                       "Appellant",
                       "Owner Occupier", 
                       "Owner Occupier", 
                       "Landowner",
                       "Prescribed Body",
                       "Prospective Applicant",
                       "Prospective Applicant",
                       "Prospective Applicant",
                       "Referrer",
                       "Referrer",
                       "Referrer",
                       "Third Party",
                       "Referrer",
                       "Referrer",
                       "Invited",
                       "Invited",
                       "Invited",
                       "Invited",
                       "Planning Authority",
                       "Planning Authority",
                       "Planning Authority",
                       "Prescribed Body",
                       "Developer",
                       "Dismissed")

party_kinds <- data.frame(raw_party_kinds = party_kinds, clean_party_kinds = clean_party_kinds)
party_kinds

#party_kinds <- as_tibble(party_kinds) 
#clean_party_kinds <- as_tibble(clean_party_kinds)
#party_kinds <- left_join(party_kinds,clean_party_kinds)




party_status <- c('(Active)', 
                  '(Invalid)',
                  '(Invalid Grounds)',
                  '(Invalid-Grounds)',
                  '(Invalid Grounds)',
                  '(Invalid-no acknowls127(1)e)',
                  '(Invalid-name/adds4(1)(b))',
                  '(Invalid-fee s4(1)(e))',
                  '(Late S37(1)(g))',
                  '(Invalid-Fee)',
                  '(Invalid s37(6)(a)Late)',
                  '(Invalid- No Board Jurisdiction)',
                  '(Invalid s37(6)(a)Not land adj)',
                  '(Invalid-Person Sec5(1))',
                  '(Invalid-Name/Address)',
                  '(Invalid-fee Sec 5(3)(a))',
                  '(Invalid-Late Sec 5(3)(b))',
                  '(Invalid-Hours)',
                  '(Invalid-Subject)',
                  '(Invalid-No Req Sec5(1))',
                  '(Withdrawn)',
                  '(Application W/D  S.140(1)(a))',
                  '(Appeal DecW/D   S140(2)(b))',
                  '(Appeal Withdrawn S140(1)(a))',
                  '(Wthdrawn Section 140 (1)(a))',
                  '(Application W/D  S140(1)(a))')

clean_party_status <- c('Active', 
                  'Invalid',
                  'Invalid',
                  'Invalid',
                  'Invalid',
                  'Invalid',
                  'Invalid',
                  'Invalid',
                  'Invalid',
                  'Invalid',
                  'Invalid',
                  'Invalid',
                  'Invalid',
                  'Invalid',
                  'Invalid',
                  'Invalid',
                  'Invalid',
                  'Invalid',
                  'Invalid',
                  'Invalid',
                  'Withdrawn',
                  'Withdrawn',
                  'Withdrawn',
                  'Withdrawn',
                  'Withdrawn',
                  'Withdrawn')

party_status <- data.frame(raw_party_status = party_status, clean_party_status = clean_party_status)
party_status

                  
business_forms <- c('ltd.',
                    ' ltd ',
                    'limited',
                    'LTD',
                    'Limited',
                    'plc',
                    'PLC',
                    'Plc',
                    'Group',
                    'group',
                    'T/A',
                    'GmbH',
                    'gmbh',
                    'Gmbh',
                    'llc',
                    'Llc',
                    'LLC',
                    'REIT',
                    'Irish Water',
                    'ESB',
                    'EIRGRID',
                    'Management',
                    'Bank of Ireland',
                    'Coras Iompair',
                    '(Unlimited Company)',
                    'Holdings',
                    'Investments',
                    'ICAV',
                    "Developments",
                    "Teoranta",
                    "CLG",
                    " clg ",
                    "Company",
                    'Associates',
                    'Consultants',
                    'Solutions',
                    ' teo ',
                    ' TEO ',
                    'Aldi ',
                    "Bank of Ireland"
                    )

cleaning_parties <- FALSE

if(cleaning_parties){
  for (i in  1:100) {
    this_column <-  paste(hold_party, toString(i),sep = "")
  #  print(this_column)
  #  print(which(colnames(data) == this_column))
    
    source_event_column_id <- which(colnames(data) == this_column)
    #cycle through the columns
    #create three new columns for each party column
    
    party_key_name = paste(this_column,"_name",sep = "") 
    party_key_kind = paste(this_column,"_kind",sep = "")
    party_key_status = paste(this_column,"_status",sep = "")
    
    party_key_name
    
    party_key = tibble(
      !!party_key_name   :="",
      !!party_key_kind    :="",
      !!party_key_status :="",
      "application_id" = data$application_id
      )
    
    
    
    #party_key$name=""
    #party_key$kind=""
    #party_key$status=""
    
    #party_key$application_id = data$application_id
    #party_key$name=""
    #party_key$kind=""
    #party_key$status=""
    
    
    
    party_kinds
    if(!is.na(data[1,source_event_column_id])){  #### catches null columns    
      
      
      for (iterator in 1:length(party_kinds$raw_party_kinds)){
      
      
   #   print(party_kinds$raw_party_kinds[iterator])
  #    print(party_kinds$clean_party_kinds[iterator])
      
      seek_text <- party_kinds$raw_party_kinds[iterator]
      
      #party_kinds$raw_party_kinds[iterator] finds the first raw party text content
      #######
      #######
      #::::: unlist(gregexpr(party_kinds$raw_party_kinds[iterator], data$party_1))
      #finds all the rows which contain that text
      
      ### data[,source_event_column_id] - contents of the source column we're looking at
      
      index_text <- unlist(gregexpr(seek_text, data[,source_event_column_id]))
      ##### this returns the index in each cell where the sought string is to be found, and -1
      ##### if it is not found
      

        
        
        index_text <- as_tibble(index_text)
        index_text
        #party_key[index_text>0,1] <- 
        #data[index_text>0,source_event_column_id] %>% substr(1,index_text$value[index_text$value>0]-3)
        
        ##assigns party name
        
        party_key[index_text>0,1] <- data[index_text>0,source_event_column_id] %>% substr(1,index_text$value[index_text$value>0]-3)
        party_key
        
        party_key[index_text>0,2] <- party_kinds$clean_party_kinds[iterator]  ### assigns clean party kind
        party_key
      
      }
      #party_key[party_key$party_1_kind=="",]
      
      #party_key %>% count(party_key$party_1_kind)
      
      #####assigning party status
      
      for (iterator in 1:length(party_status$raw_party_status)){
        
    #    print(party_status$raw_party_status[iterator])
    #    print(party_status$clean_party_status[iterator])
    
        seek_text <- party_status$raw_party_status[iterator]
        
        #party_kinds$raw_party_kinds[iterator] finds the first raw party text content
        #######
        #######
        #::::: unlist(gregexpr(party_kinds$raw_party_kinds[iterator], data$party_1))
        #finds all the rows which contain that text
        
        ### data[,source_event_column_id] - contents of the source column we're looking at
        
  
        
        index_text <- unlist(gregexpr(seek_text, data[,source_event_column_id]))
        index_text[index_text>0] 
        class(index_text)
        ##### this returns the index in each cell where the sought string is to be found, and -1
        ##### if it is not found
        
        index_text <- as_tibble(index_text)
        row(index_text[index_text$value>0,])
        
        party_key[index_text>0,3] <- party_status$clean_party_status[iterator]  ### assigns clean party status
        
        ##checks if name is blank (because no kind registered above)
        #if name is blank then assigns name  
        party_key[((party_key[,1]=="")&(index_text>0)),1] <- 
          data[((party_key[,1]=="")&(index_text>0)),source_event_column_id] %>% substr(1,index_text$value[index_text$value>0]-3)
      
        
        party_key[((party_key[,1]=="")&(index_text>0)),2] <- "Undeclared"  ### assigns clean party kind
        
        party_key
      }
    }
    
    data <- left_join(data,party_key, by="application_id")
    
    }
  
      
    
    ###Have to organise the order in which I create the new files so that 
    #I can ensure that I'm feeding in the correct ID's at each stage
    #need to have a bit of a thing about that one. linked cases is last
    #Decisions and associated reference lists need to be next
    #Kinds lists for parties and status's next, and then the events one
    #(still to be done)
    #then once all the atomic elements are sorted, can do applications
    #finally linked cases (watch out for the quashed ones)

  }


write.csv(data, file = "work_file_parties.csv")



#for date event date field
#write new row for event with event: date: application_id:
#Should I clean them up? nope repeating status info, and not adding much 

#for each of the atomic fields, I should  count by and add index for the index and text field
#Case_Type/Case_Type_Detail/ Case_decision
#party_kind/party_status/

##complicated fields - legal entity - but before application
#events
#after application

#linked lists????? should I??????
if(!cleaning_parties){
  data <- read.csv("work_file_parties.csv")    ####  reload data from back up with parties cleaned
}

#case type lookup created

Case_Type_indexer <- data %>% 
  group_by(case_Type) %>%
  count()


Case_Type_indexer
Case_Type_indexer <- tibble::rowid_to_column(Case_Type_indexer, "case_type_id")

case_type <- Case_Type_indexer

#case type  detail lookup created

Case_Type_Detail_indexer <- data %>% 
  group_by(case_Type_Detail) %>%
  count()

Case_Type_Detail_indexer <- tibble::rowid_to_column(Case_Type_Detail_indexer, "case_type_detail_id")
Case_Type_Detail_indexer




#case status lookup created

Case_status_indexer <- data %>% 
  group_by(case_Decision) %>%
  count()

Case_status_indexer <- Case_status_indexer%>%
  rename(
    case_status = case_Decision
  )


Case_status_indexer
Case_status_indexer <- tibble::rowid_to_column(Case_status_indexer, "case_status_id")

case_type  <- Case_status_indexer


## party kind lookup created



##### Merge all the party kinds into one  column

stacked_parties <- ""

for (i in 1:100) {

    target_column = ""  
    
    target_column <-  paste("party_", toString(i),"_kind", sep = "")
    
  #  print(this_column)
  #  print(which(colnames(data) == this_column))
    source_event_column_id <- which(colnames(data) == target_column)

    stacked_parties <- c(stacked_parties, data[, source_event_column_id])
    
  }
            ## remove NA's
stacked_parties <- as_tibble(stacked_parties[!is.na(stacked_parties)])



stacked_parties

#stacked_parties <- stacked_parties[!stacked_parties$value=="",]

party_kind_indexer <- stacked_parties %>% 
  group_by(value) %>%
  count()

party_kind_indexer

party_kind_indexer <- party_kind_indexer%>%
  rename(
    party_kind = value
  )

party_kind_indexer <- tibble::rowid_to_column(party_kind_indexer, "party_kind_id")
party_kind_indexer


#######################################


##### Merge all the party status's into one  column

stacked_party_status <- ""

for (i in 1:100) {
  
  target_column = ""  
  
  target_column <-  paste("party_", toString(i),"_status", sep = "")
  
  #  print(this_column)
  #  print(which(colnames(data) == this_column))
  source_event_column_id <- which(colnames(data) == target_column)
  
  stacked_party_status <- c(stacked_party_status, data[, source_event_column_id])
  
}
## remove NA's
stacked_party_status <- as_tibble(stacked_party_status[!is.na(stacked_party_status)])



stacked_party_status$value

#stacked_party_status <- stacked_party_status[!stacked_party_status$value=="",]

party_status_indexer <- stacked_party_status %>% 
  group_by(value) %>%
  count()

party_status_indexer

party_status_indexer <- party_status_indexer%>%
  rename(
    party_status = value
  )

party_status_indexer <- tibble::rowid_to_column(party_status_indexer, "case_status_id")
party_status_indexer


##############################

######    legal_entity_creater

stacked_party_names <- ""

for (i in 1:100) {
  
  target_column = ""  
  
  target_column <-  paste("party_", toString(i),"_name", sep = "")
  
  #  print(this_column)
  #  print(which(colnames(data) == this_column))
  source_event_column_id <- which(colnames(data) == target_column)
  
  stacked_party_names <- c(stacked_party_names, data[, source_event_column_id])
  
}
## remove NA's



for (i in 1:length(party_kinds$raw_party_kinds)) {
  stacked_party_names <- (str_remove_all(stacked_party_names, party_kinds$raw_party_kinds[i]))
}

for (i in 1:length(party_status$raw_party_status)) {
  stacked_party_names <- (str_remove_all(stacked_party_names, party_status$raw_party_status[i]))
}


stacked_party_names <- (str_remove_all(stacked_party_names, 'Party'))

stacked_party_names <- (str_remove_all(stacked_party_names, "[[()]]"))




#str_replace_all(x, "[[:punct:]]", " ")

stacked_party_names <- (str_remove_all(stacked_party_names, '~'))
stacked_party_names <- (str_replace_all(stacked_party_names, "[[&]]", ' and '))
stacked_party_names <- str_replace_all(stacked_party_names, '  ', ' ')
stacked_party_names <- str_replace_all(stacked_party_names, '  ', ' ')
stacked_party_names <- str_replace_all(stacked_party_names, '  ', ' ')
stacked_party_names <- str_replace_all(stacked_party_names, '  ', ' ')


stacked_party_names

stacked_party_names <- as_tibble(stacked_party_names[!is.na(stacked_party_names)])

index_text<- regexpr("taisce", stacked_party_names$value)

stacked_party_names$value[index_text>0] <- "An Taisce"

index_text<- regexpr("Taisce", stacked_party_names$value)

stacked_party_names$value[index_text>0] <- "An Taisce"


index_text<- regexpr("Aldi", stacked_party_names$value)

stacked_party_names$value[index_text>0] <- "Aldi"

index_text<- regexpr("aldi", stacked_party_names$value)

stacked_party_names$value[index_text>0] <- "Aldi"



index_text<- regexpr("An Chomhaire Ealaion", stacked_party_names$value)
index_text>0
stacked_party_names$value[index_text>0] <- "The Arts Council"

index_text<- regexpr("An Comhairle Ealaoin", stacked_party_names$value)
index_text>0
stacked_party_names$value[index_text>0] <- "The Arts Council"

index_text<- regexpr("An Chomhair", stacked_party_names$value)
index_text>0
stacked_party_names$value[index_text>0] <- "The Arts Council"

index_text<- regexpr(" ESB ", stacked_party_names$value)
index_text>0
stacked_party_names$value[index_text>0] <- "ESB"

index_text<- regexpr("Irish Water", stacked_party_names$value)
index_text>0
stacked_party_names$value[index_text>0] <- "Irish Water"

#"An Chomhairle Ealaíon"


stacked_party_names$value

stacked_party_names <- stacked_party_names[!stacked_party_names$value=="",]


party_name_indexer <- stacked_party_names %>% 
  group_by(value) %>%
  count()

party_name_indexer

party_name_indexer <- party_name_indexer%>%
  rename(
    legal_entity = value
  )

party_name_indexer <- tibble::rowid_to_column(party_name_indexer, "legal_entity_id")
party_name_indexer

party_name_indexer$Business <- FALSE

party_name_indexer

i=2

for (i in 1:length(business_forms)){

  seek_text <- business_forms[i]
  
  #party_kinds$raw_party_kinds[iterator] finds the first raw party text content
  #######
  #######
  #::::: unlist(gregexpr(party_kinds$raw_party_kinds[iterator], data$party_1))
  #finds all the rows which contain that text
  
  ### data[,source_event_column_id] - contents of the source column we're looking at
  
  
  seek_text
  #index_text <- unlist(gregexpr(seek_text, party_name_indexer$legal_entity))
  
  #index_text <- as_tibble(index_text)
  
  
  index_text<- regexpr(seek_text, party_name_indexer$legal_entity)
  
  party_name_indexer$Business[index_text>0] <- TRUE
  
}



#### removing counts to avoid later conflict issues when mergeing tibbles

Case_Type_indexer <- select(Case_Type_indexer, -n)
Case_Type_Detail_indexer <- select(Case_Type_Detail_indexer, -n)
Case_status_indexer <- select(Case_status_indexer, -n)
party_kind_indexer <- select(party_kind_indexer, -n)
party_status_indexer <- select(party_status_indexer, -n)
party_name_indexer <- select(party_name_indexer, -n)







party_name_indexer$legal_entity[!party_name_indexer$Business]

application_indexer <- as_tibble(data$application_id)

application_indexer <- application_indexer %>%
  rename(
    application_id = value
    
  )
application_indexer
application_indexer <- add_column(application_indexer, abp_application_id= data$abp_application_id)
application_indexer <- add_column(application_indexer, case_reference = data$case_reference)
application_indexer <- add_column(application_indexer, case_address = data$case_address)
application_indexer

county_councils <- ""

county_councils <- as_tibble(data$case_council)


county_councils <- county_councils %>%
  rename(
    legal_entity = value
  )


county_councils
county_councils <- left_join(county_councils, party_name_indexer, by="legal_entity" )


application_indexer <- add_column(application_indexer, case_council = county_councils$legal_entity_id)
application_indexer <- add_column(application_indexer, case_description = data$case_Description)


###############case types

case_types <- as_tibble(data$case_Type)
case_types <- case_types %>%
  rename (
    case_Type = value
  )

case_types <- left_join(case_types, Case_Type_indexer, by="case_Type" )

application_indexer <- add_column(application_indexer, case_type_id = case_types$case_type_id)

############## case type details

case_type_details <- as_tibble(data$case_Type_Detail)
case_type_details
case_type_details <- case_type_details %>%
  rename (
    case_Type_Detail = value
  )



case_type_details <- left_join(case_type_details, Case_Type_Detail_indexer, by="case_Type_Detail" )

application_indexer <- add_column(application_indexer, case_type_detail_id = case_type_details$case_type_detail_id)


################## case statuses
case_statuses <- as_tibble(data$case_Decision)


case_statuses <- case_statuses%>%
  rename(
    case_status = value
  )

case_statuses <- left_join(case_statuses, Case_status_indexer, by="case_status")

application_indexer <- add_column(application_indexer, case_status_id = case_statuses$case_status_id)


#######################EIAR / NIS

application_indexer$case_EIAR <- data$case_EIAR=="Yes"
application_indexer$case_NIS  <- data$case_NIS=="Yes"



data$case_Date_Signed
case_Date_Signed <-""
case_Date_Signed <- format(strptime(as.character(data$case_Date_Signed), "%d/%m/%Y"), "%Y-%m-%d")

case_Date_Signed <- as_tibble(case_Date_Signed)
case_Date_Signed <- case_Date_Signed %>%
  rename(
    case_date_signed = value
    
  )

application_indexer <- add_column(application_indexer, case_date_signed = case_Date_Signed$case_date_signed)
application_indexer[!is.na(application_indexer$case_date_signed),]
applications <- application_indexer

######## events  

holder_events=""

for (i in 1:10){
  this_column <-  paste("event_", toString(i),"_date",sep = "")
  #  print(this_column)
  #  print(which(colnames(data) == this_column))
  
  source_event_column_id <- which(colnames(data) == this_column)
  source_event_column_id
  
  if(!is.na(data[1,source_event_column_id])){
    application_events_working <- as_tibble(data[,source_event_column_id])
    application_events_working
    application_events_working <- application_events_working %>%
      rename(
        event_date = value
        
      )
    application_events_working <- add_column(application_events_working, application_id = data$application_id)
    
    
    #events details column
    this_details_index <-  paste("event_", toString(i),sep = "")
    
    events_details <- as_tibble(data[,this_details_index])
    events_details
    events_details <- events_details %>%
      rename(
        event_status = value
      )
    
    events_details <- add_column(events_details, application_id = data$application_id)
    
    application_events_working <- application_events_working[!application_events_working$event_date=="",]

  
    application_events_working <- left_join(application_events_working, events_details, by="application_id")
    application_events_working
    if (i==1){
      holder_events <- application_events_working
      }
    if (i>1){
      holder_events <- bind_rows(holder_events, application_events_working)
    }
  }

} 

application_events <- tibble::rowid_to_column(holder_events, "application_events_id")


#### documents

documents_holder <- ""
for (i in 1:100){
  this_column <-  paste("link_", toString(i),sep = "")
  #  print(this_column)
  #  print(which(colnames(data) == this_column))
  
  source_event_column_id <- which(colnames(data) == this_column)
  source_event_column_id
  !is.na(data[1,source_event_column_id])
  as_tibble(data[,source_event_column_id])
  
  if(!is.na(data[1,source_event_column_id])){
    documents_working <- as_tibble(data[,source_event_column_id])
    documents_working <- documents_working %>%
      rename(
        url = value
      )
    documents_working <- add_column(documents_working, application_id = data$application_id)
    documents_working <- documents_working[!documents_working$url=="",]
    documents_working
    if(i==1){
      documents_holder <-documents_working 
    }
    if (i>1){
      documents_holder <- bind_rows(documents_holder, documents_working)
      
    }
    documents_holder
    
  }
}
documents_holder %>% arrange(application_id)

documents_holder <- documents_holder[!documents_holder$url=="javascript:;",]
documents_holder
documents <- tibble::rowid_to_column(documents_holder, "documents_id")
documents$url <- paste("https://www.pleanala.ie", documents$url,sep = "")
documents


############################

#parties = 

i=1
party_holder <- ""
for (i in 1:100){
  this_column <-  paste("party_", toString(i),"_name",sep = "")
  this_party_kind <-  paste("party_", toString(i),"_kind",sep = "")
  this_party_status <-  paste("party_", toString(i),"_status",sep = "")
  #  print(this_column)
  #  print(which(colnames(data) == this_column))
  
  source_party_column_id <- which(colnames(data) == this_column)
  source_party_kind_id   <- which(colnames(data) == this_party_kind)
  source_party_status_id <- which(colnames(data) == this_party_status)

  if(!is.na(data[1,source_party_column_id])){
    
    #### party names
    
    party_working <- as_tibble(data[,source_party_column_id])
    party_working <- party_working %>%
      rename(
        legal_entity_raw_name = value
      )

    
    party_working <- add_column(party_working, application_id = data$application_id)
    
    
    ##### party kinds
    
    party_kind_working <- as_tibble(data[,source_party_kind_id])
    party_kind_working <- party_kind_working %>%
      rename(
        party_kind = value
      )
    
    party_kind_working <- add_column(party_kind_working, application_id = data$application_id)
    
    ###### party statuses
    
    party_status_working <- as_tibble(data[,source_party_status_id])
    party_status_working <- party_status_working %>%
      rename(
        party_status = value
      )
    
    party_status_working <- add_column(party_status_working, application_id = data$application_id)
    
    
    party_working <- left_join(party_working, party_kind_working, by="application_id")
    party_working <- left_join(party_working, party_status_working, by="application_id")
    party_working
    
    #### clear out blank names
    
    party_working <- party_working[!party_working$legal_entity_raw_name=="",]
    
    party_working <- left_join(party_working, party_kind_indexer, by="party_kind")
    
    party_status_indexer
    
    party_working <- left_join(party_working, party_status_indexer, by="party_status")
    
    if(i==1){
      party_holder <-party_working 
    }
    if (i>1){
      party_holder <- bind_rows(party_holder, party_working)
      
    }
    
  }
}


party_holder
cleaninglegal_entity_name <- party_holder$legal_entity_raw_name


#### have to clean the names to find the legal entity ID
#### I should probably do this by function, but am feeling tined


####this bit removed the statuses/kinds from party names
for (i in 1:length(party_kinds$raw_party_kinds)) {
  cleaninglegal_entity_name <- (str_remove_all(cleaninglegal_entity_name, party_kinds$raw_party_kinds[i]))
}

for (i in 1:length(party_status$raw_party_status)) {
  cleaninglegal_entity_name <- (str_remove_all(cleaninglegal_entity_name, party_status$raw_party_status[i]))
}

party_holder$legal_entity_name<-cleaninglegal_entity_name

###excluded holdover party, and all partenteses

party_holder$legal_entity_name <- (str_remove_all(party_holder$legal_entity_name, 'Party'))

party_holder$legal_entity_name <- (str_remove_all(party_holder$legal_entity_name, "[[()]]"))




#str_replace_all(x, "[[:punct:]]", " ")

party_holder$legal_entity_name <- (str_remove_all(party_holder$legal_entity_name, '~'))
party_holder$legal_entity_name <- (str_replace_all(party_holder$legal_entity_name, "[[&]]", ' and '))
party_holder$legal_entity_name <- str_replace_all(party_holder$legal_entity_name, '  ', ' ')
party_holder$legal_entity_name <- str_replace_all(party_holder$legal_entity_name, '  ', ' ')
party_holder$legal_entity_name <- str_replace_all(party_holder$legal_entity_name, '  ', ' ')
party_holder$legal_entity_name <- str_replace_all(party_holder$legal_entity_name, '  ', ' ')


party_holder$legal_entity_name

index_text<- regexpr("taisce", party_holder$legal_entity_name)

party_holder$legal_entity_name[index_text>0] <- "An Taisce"

index_text<- regexpr("Taisce", party_holder$legal_entity_name)

party_holder$legal_entity_name[index_text>0] <- "An Taisce"


index_text<- regexpr("Aldi", party_holder$legal_entity_name)

party_holder$legal_entity_name[index_text>0] <- "Aldi"

index_text<- regexpr("aldi", party_holder$legal_entity_name)

party_holder$legal_entity_name[index_text>0] <- "Aldi"



index_text<- regexpr("An Chomhaire Ealaion", party_holder$legal_entity_name)
index_text>0
party_holder$legal_entity_name[index_text>0] <- "The Arts Council"

index_text<- regexpr("An Comhairle Ealaoin", party_holder$legal_entity_name)
index_text>0
party_holder$legal_entity_name[index_text>0] <- "The Arts Council"

index_text<- regexpr("An Chomhair", party_holder$legal_entity_name)
index_text>0
party_holder$legal_entity_name[index_text>0] <- "The Arts Council"

index_text<- regexpr(" ESB ", party_holder$legal_entity_name)
index_text>0
party_holder$legal_entity_name[index_text>0] <- "ESB"

index_text<- regexpr("Irish Water", party_holder$legal_entity_name)
index_text>0
party_holder$legal_entity_name[index_text>0] <- "Irish Water"


party_holder[!party_holder$legal_entity_raw_name==party_holder$legal_entity_name,]

party_holder_work <- party_holder

party_holder_work <- party_holder_work %>%
  rename(
    legal_entity = legal_entity_name
  )


party_holder_work <- left_join(party_holder_work, party_name_indexer, by="legal_entity")

party_holder_work <- party_holder_work %>%
  rename(
    party_status_id = case_status_id
  )

parties <- select(party_holder_work, application_id, legal_entity_id, party_kind_id, party_status_id)


parties <- tibble::rowid_to_column(parties, "party_id")



###################
###################

#create finalised verstions to tidy up names before printing to csvs

applications <- application_indexer
case_type <-Case_Type_indexer
case_type_details <- Case_Type_Detail_indexer
case_status <- Case_status_indexer
parties <-parties
party_kind <-party_kind_indexer
party_status <- party_status_indexer
legal_entity <- party_name_indexer
application_events <-  application_events
documents <- documents


colnames(applications)
colnames(case_type) 
case_type <- case_type %>%
  rename(
    case_type_name = case_Type
  )

colnames(case_type_details)
case_type_details <- case_type_details %>%
  rename(
    case_type_detail_name = case_Type_Detail
  )  
colnames(case_type_details)

colnames(case_status) 
case_status <- case_status %>%
  rename(
    case_status_name = case_status
  )  
colnames(case_status) 

colnames(parties)


colnames(party_kind) 
party_kind <- party_kind %>%
  rename(
    party_kind_name = party_kind
  )  
colnames(party_kind) 


colnames(party_status)
party_status <- party_status %>%
  rename(
    party_status_name = party_status
  )  

party_status <- party_status %>%
  rename(
    party_status_id = case_status_id
  )  

colnames(party_status) 


colnames(legal_entity) 
legal_entity <- legal_entity %>%
  rename(
    legal_entity_name = legal_entity
  )  
colnames(legal_entity) 


         
colnames(application_events)

colnames(documents)

########################

#catch the commas in text fields before they ruin the csvs

applications$case_address <- str_remove_all(applications$case_address, ',')
applications$case_description <- str_remove_all(applications$case_description, ',')

application_events$event_status <- str_remove_all(application_events$event_status, ',')


###print csvs


write.csv(applications, "applications.csv", row.names = FALSE,fileEncoding="UTF-16")
write.csv(case_type, "case_type.csv", row.names = FALSE,fileEncoding="UTF-16")
write.csv(case_type_details, "case_type_details.csv", row.names = FALSE,fileEncoding="UTF-16")
write.csv(case_status,"case_status.csv", row.names = FALSE,fileEncoding="UTF-16")
write.csv(parties,"parties.csv", row.names = FALSE,fileEncoding="UTF-16")
write.csv(party_kind,"party_kind.csv", row.names = FALSE,fileEncoding="UTF-16")
write.csv(party_status,"party_status.csv", row.names = FALSE,fileEncoding="UTF-16")
write.csv(legal_entity,"legal_entity.csv", row.names = FALSE,fileEncoding="UTF-16")
write.csv(application_events,"application_events.csv", row.names = FALSE,fileEncoding="UTF-16")
write.csv(documents,"documents.csv", row.names = FALSE,fileEncoding="UTF-16")



#######################

start_dates <- application_events[application_events$event_status=="Lodged",]
start_dates$end_date <-""

count_application_events <- ""


count_application_events <- application_events  %>%
  group_by(application_id)%>%
  count()

count_application_events[count_application_events$n<2,]

length(once_off_events$application_id)
once_off_events <- count_application_events[count_application_events$n<2,]
length(once_off_events$application_id)

once_off_events <- left_join(once_off_events, application_events, by="application_id")
once_off_events <- once_off_events[!(once_off_events$event_status=="Lodged"),]

length(start_dates$application_id)
length(once_off_events$application_id)



#for (iterator in 1:length(once_off_events$application_id)) {

#  iterator_id = once_off_events$application_id[iterator]
 # print(iterator_id)
#  print(start_dates$application_id[start_dates$application_id==iterator_id])
#  if((length(start_dates$application_id[start_dates$application_id==iterator_id]))==0){
#    start_dates <- start_dates %>%
#    add_row(application_events[application_events$application_id==iterator_id,])
    
#  }

#}

length(start_dates$application_id)
length(once_off_events$application_id)




for (iterator in 1:length(start_dates$application_id )){
  start_dates$end_date[iterator] <- data$case_Date_Signed[data$application_id==start_dates$application_id[iterator]]
  
}

start_dates

start_dates$invalid<- FALSE

start_dates$invalid[start_dates$event_date==start_dates$end_date] <- TRUE

start_dates[!start_dates$invalid,]


start_dates$Still_open <- FALSE

start_dates$Still_open[start_dates$end_date==""] <- TRUE

start_dates[!start_dates$Still_open,]

start_dates$end_date <- format(strptime(as.character(start_dates$end_date), "%d/%m/%Y"), "%Y-%m-%d")
start_dates$event_date <- format(strptime(as.character(start_dates$event_date), "%d/%m/%Y"), "%Y-%m-%d")


start_dates$total_days =""
start_dates$total_days[!start_dates$invalid & !start_dates$Still_open] <-round(difftime(start_dates$end_date[!start_dates$invalid & !start_dates$Still_open], start_dates$event_date[!start_dates$invalid & !start_dates$Still_open], units = "days"))


start_dates$total_days[!start_dates$invalid & start_dates$Still_open] <- round(difftime("2023-1-1",
               start_dates$event_date[!start_dates$invalid & start_dates$Still_open]))




mean(strtoi(start_dates$total_days[!start_dates$total_days==""]))

median(strtoi(start_dates$total_days[!start_dates$total_days==""]))

start_dates$total_days[((!start_dates$total_days=="")&(start_dates$total_days<0))] <- 0

annual_records <-""

annual_records <- as_tibble(c(2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023))
annual_records <- annual_records %>%
  rename(
    year = value
  )


start_dates$total_days[start_dates$invalid] <- 0

x="2016"

hold_dates <- start_dates

hold_dates[is.na(hold_dates$end_date),]


hold_dates$end_date[hold_dates$end_date==""] <- "2023-12-31"

hold_dates$end_date[is.na(hold_dates$end_date)] <- "2023-12-31"

annual_records$mean <- ""
annual_records$median <- ""
#annual_records$mode <- ""
annual_records$max <- ""
annual_records$min <- ""

annual_records$open_cases <- ""
annual_records$new_cases <- ""
annual_records$new_valid_cases <- ""

annual_records$closed_cases <- ""
annual_records$closed_cases_mean_time_open <- ""
annual_records$closed_cases_median_time_open <- ""
#annual_records$closed_cases_mode_time_open <- ""

x=2017

for (x in 2000:2023){
  new_year <- paste(x, "-1-1",sep = "")
  new_year
  this_year <- hold_dates[(difftime(new_year, hold_dates$event_date) > 0) & (difftime(new_year, hold_dates$end_date) < 0),]
  

  
  this_year$days_open <- ""
  this_year$days_open <- round(difftime(new_year, this_year$event_date))
  length(this_year$days_open)
  
  annual_records$mean[annual_records$year==x] <- round(mean(this_year$days_open))
  annual_records$median[annual_records$year==x] <- round(median(this_year$days_open))
 # annual_records$mode[annual_records$year==x] <- mode(this_year$days_open)
  annual_records$max[annual_records$year==x] <- max(this_year$days_open)
  annual_records$min[annual_records$year==x] <- min(this_year$days_open)
  
  annual_records$open_cases[annual_records$year==x] <- length(this_year$application_id)
  
  #########################

  
  print(annual_records, n=25)
  y_before <- strtoi(x)-1
  YtoY <- paste(y_before,"-1-1",sep="")
  YtoY
  
    
  #new cases open 

  new_cases <- hold_dates[(difftime(new_year, hold_dates$event_date)>0)&(difftime(YtoY, hold_dates$event_date)<0),]
    
  annual_records$new_cases[annual_records$year==x] <- length(new_cases$application_id)
  annual_records$new_valid_cases[annual_records$year==x] <- length(new_cases$application_id[!new_cases$invalid])
  
  

  ######################
  
  #cases closed
  
  
  
  
#  print(annual_records, n=25)
  annual_cases <- hold_dates[(difftime(new_year, hold_dates$end_date)>0)&(difftime(YtoY, hold_dates$end_date)<0),]
  annual_cases <- annual_cases[!annual_cases$invalid,]
  
  
  annual_records$closed_cases[annual_records$year==x] <- length(annual_cases$application_id)
  
  
  
  if(annual_records$closed_cases[annual_records$year==x]>0){
    
    annual_records$closed_cases_mean_time_open[annual_records$year==x] <- round(mean(strtoi(annual_cases$total_days)))
    annual_records$closed_cases_median_time_open[annual_records$year==x] <- round(median(strtoi(annual_cases$total_days)))
    # annual_records$closed_cases_mode_time_open[annual_records$year==x] <- round(mode(strtoi(annual_cases$total_days)))
  }else{
    annual_records$closed_cases_mean_time_open[annual_records$year==x] <- NA
    annual_records$closed_cases_median_time_open[annual_records$year==x] <- NA
    annual_records$closed_cases_mode_time_open[annual_records$year==x] <- NA
  
  }  
  
  }

print(annual_records, n=25)

dirty_data <- tibble(
  application_id = data$application_id,
  abp_application_id = data$abp_application_id,
  case_council = data$case_council,
  case_Type_raw = data$case_Type_raw,
  case_Decision_raw = data$case_Decision_raw,
  case_Date_Signed = data$case_Date_Signed,
  party_1 = data$party_1,
  party_2 = data$party_2,
  case_reference = data$case_reference
)



write.csv(dirty_data, "dirty_data.csv", col.names = FALSE)


write.csv(start_dates, "start_dates.csv", col.names = FALSE)
  