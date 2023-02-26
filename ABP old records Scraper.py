from bs4 import BeautifulSoup
import requests
import csv

#input_file = open("old_format_scrape_targets_checked.csv", "r", encoding='utf-8')
input_file = open("problem_scrape_targets_checked.csv", "r", encoding='utf-8')
reader = csv.reader(input_file)

output_file = open('csv_file_old_records_output.csv', 'a', encoding='utf-8', newline='')
writer = csv.writer(output_file)

bad_numbers_file = open('bad_numbers_old_records.csv', 'a', encoding='utf-8', newline='')
bad_numbers_writer = csv.writer(output_file)


header = [
        "application_id",
        "case_reference",
        "case_address",
        "case_council",
        "case_Description",
        "case_Type",
        "case_Decision",
        "case_Date_Signed",
        "case_EIAR",
        "case_NIS",
        "case_parties",
        "party_1",
        "party_2",
        "party_3",
        "party_4",
        "party_5",
        "party_6",
        "party_7",
        "party_8",
        "party_9",
        "party_10",
        "party_11",
        "party_12",
        "party_13",
        "party_14",
        "party_15",
        "party_16",
        "party_17",
        "party_18",
        "party_19",
        "party_20",
        "party_21",
        "party_22",
        "party_23",
        "party_24",
        "party_25",
        "party_26",
        "party_27",
        "party_28",
        "party_29",
        "party_30",
        "party_31",
        "party_32",
        "party_33",
        "party_34",
        "party_35",
        "party_36",
        "party_37",
        "party_38",
        "party_39",
        "party_40",
        "party_41",
        "party_42",
        "party_43",
        "party_44",
        "party_45",
        "party_46",
        "party_47",
        "party_48",
        "party_49",
        "party_50",
        "party_51",
        "party_52",
        "party_53",
        "party_54",
        "party_55",
        "party_56",
        "party_57",
        "party_58",
        "party_59",
        "party_60",
        "party_61",
        "party_62",
        "party_63",
        "party_64",
        "party_65",
        "party_66",
        "party_67",
        "party_68",
        "party_69",
        "party_70",
        "party_71",
        "party_72",
        "party_73",
        "party_74",
        "party_75",
        "party_76",
        "party_77",
        "party_78",
        "party_79",
        "party_80",
        "party_81",
        "party_82",
        "party_83",
        "party_84",
        "party_85",
        "party_86",
        "party_87",
        "party_88",
        "party_89",
        "party_90",
        "party_91",
        "party_92",
        "party_93",
        "party_94",
        "party_95",
        "party_96",
        "party_97",
        "party_98",
        "party_99",
        "party_100"
        "event_1",
        "event_2",
        "event_3",
        "event_4",
        "event_5",
        "event_6",
        "event_7",
        "event_8",
        "event_9",
        "event_10",
        "event_1_date",
        "event_2_date",
        "event_3_date",
        "event_4_date",
        "event_5_date",
        "event_6_date",
        "event_7_date",
        "event_8_date",
        "event_9_date",
        "event_10_date",
        "case_links",
        "link_1",
        "link_2",
        "link_3",
        "link_4",
        "link_5",
        "link_6",
        "link_7",
        "link_8",
        "link_9",
        "link_10",
        "link_11",
        "link_12",
        "link_13",
        "link_14",
        "link_15",
        "link_16",
        "link_17",
        "link_18",
        "link_19",
        "link_20",
        "link_21",
        "link_22",
        "link_23",
        "link_24",
        "link_25",
        "link_26",
        "link_27",
        "link_28",
        "link_29",
        "link_30",
        "link_31",
        "link_32",
        "link_33",
        "link_34",
        "link_35",
        "link_36",
        "link_37",
        "link_38",
        "link_39",
        "link_40",
        "link_41",
        "link_42",
        "link_43",
        "link_44",
        "link_45",
        "link_46",
        "link_47",
        "link_48",
        "link_49",
        "link_50",
        "link_51",
        "link_52",
        "link_53",
        "link_54",
        "link_55",
        "link_56",
        "link_57",
        "link_58",
        "link_59",
        "link_60",
        "link_61",
        "link_62",
        "link_63",
        "link_64",
        "link_65",
        "link_66",
        "link_67",
        "link_68",
        "link_69",
        "link_60",
        "link_71",
        "link_72",
        "link_73",
        "link_74",
        "link_75",
        "link_76",
        "link_77",
        "link_78",
        "link_79",
        "link_80",
        "link_81",
        "link_82",
        "link_83",
        "link_84",
        "link_85",
        "link_86",
        "link_87",
        "link_88",
        "link_89",
        "link_90",
        "link_91",
        "link_92",
        "link_93",
        "link_94",
        "link_95",
        "link_96",
        "link_97",
        "link_98",
        "link_99",
        "link_100",
        "page_description"
        ]

writer.writerow(header)


base_case_url = "https://www.pleanala.ie/en-ie/case/"


#case_number = 315004

case_number = 315397 # most recent case number

#problem: 301545 
#case_number = 301544

bad_files = 0

for row in reader:

#while bad_files <100 :

    
    
#    target_url = base_case_url+str(case_number)

    stringed_row = str(row)
    stringed_row = stringed_row[2:-2]
    target_url = base_case_url+stringed_row
    print(target_url)

    page = requests.get(target_url)

    soup = BeautifulSoup(page.content, 'html.parser')


    #print(soup.contents)
    #pagenotfound check
    file404d = "initialise null"

    file404d = soup.find("article", class_="padder wysiwyg")



    if str(type(file404d)) == "<class 'NoneType'>" :
        
        #entered if page not 404'd
        

        bad_files = 0 #reset bad files counter 

        application_id = stringed_row

        page_description = soup.find("p", class_="intro")
        page_description = page_description.text.strip()
        
        case_details = soup.find("div", class_="case-details")

        case_reference = case_details.find("h3", class_="section-title")
        case_reference =case_reference.text.strip()
        
        case_address = case_details.find("p", class_="address")
        case_address =case_address.text.strip()

        case_council = case_details.find("p", class_="council")
        case_council =case_council.text.strip()


        case_elements = case_details.find_all("div", class_="grid-x grid-padding-x")
    
        #clean all the row variables from the earlier row
        row_type =""            #input data
        row_details = ""        #input data

        case_Description = ""   #parsed data
        case_Type = ""
        case_Decision = ""
        case_Date_Signed =""
        case_EIAR = ""
        case_NIS = ""

        #assuming 10 or fewer parties
        case_parties = 0
        this_party = ""
        party_1 = ""
        party_2 = ""
        party_3 = ""
        party_4 = ""
        party_5 = ""
        party_6 = ""
        party_7 = ""
        party_8 = ""
        party_9 = ""
        party_10 = ""
        party_11 = ""
        party_12 = ""
        party_13 = ""
        party_14 = ""
        party_15 = ""
        party_16 = ""
        party_17 = ""
        party_18 = ""
        party_19 = ""
        party_20 = ""
        party_21 = ""
        party_22 = ""
        party_23 = ""
        party_24 = ""
        party_25 = ""
        party_26 = ""
        party_27 = ""
        party_28 = ""
        party_29 = ""
        party_30 = ""
        party_31 = ""
        party_32 = ""
        party_33 = ""
        party_34 = ""
        party_35 = ""
        party_36 = ""
        party_37 = ""
        party_38 = ""
        party_39 = ""
        party_40 = ""
        party_41 = ""
        party_42 = ""
        party_43 = ""
        party_44 = ""
        party_45 = ""
        party_46 = ""
        party_47 = ""
        party_48 = ""
        party_49 = ""
        party_50 = ""
        party_51 = ""
        party_52 = ""
        party_53 = ""
        party_54 = ""
        party_55 = ""
        party_56 = ""
        party_57 = ""
        party_58 = ""
        party_59 = ""
        party_60 = ""
        party_61 = ""
        party_62 = ""
        party_63 = ""
        party_64 = ""
        party_65 = ""
        party_66 = ""
        party_67 = ""
        party_68 = ""
        party_69 = ""
        party_70 = ""
        party_71 = ""
        party_72 = ""
        party_73 = ""
        party_74 = ""
        party_75 = ""
        party_76 = ""
        party_77 = ""
        party_78 = ""
        party_79 = ""
        party_80 = ""
        party_81 = ""
        party_82 = ""
        party_83 = ""
        party_84 = ""
        party_85 = ""
        party_86 = ""
        party_87 = ""
        party_88 = ""
        party_89 = ""
        party_90 = ""
        party_91 = ""
        party_92 = ""
        party_93 = ""
        party_94 = ""
        party_95 = ""
        party_96 = ""
        party_97 = ""
        party_98 = ""
        party_99 = ""
        party_100 = ""

        #assuming 10 or fewer events
        this_event = ""
        event_1 = ""
        event_2 = ""
        event_3 = ""
        event_4 = ""
        event_5 = ""
        event_6 = ""
        event_7 = ""
        event_8 = ""
        event_9 = ""
        event_10 = ""

        event_1_date = ""
        event_2_date = ""
        event_3_date = ""
        event_4_date = ""
        event_5_date = ""
        event_6_date = ""
        event_7_date = ""
        event_8_date = ""
        event_9_date = ""
        event_10_date = ""


        #assuming 100 or fewer links
        case_links = 0
        this_link = ""
        link_1 = ""
        link_2 = ""
        link_3 = ""
        link_4 = ""
        link_5 = ""
        link_6 = ""
        link_7 = ""
        link_8 = ""
        link_9 = ""
        link_10 = ""
        link_11 = ""
        link_12 = ""
        link_13 = ""
        link_14 = ""
        link_15 = ""
        link_16 = ""
        link_17 = ""
        link_18 = ""
        link_19 = ""
        link_20 = ""
        link_21 = ""
        link_22 = ""
        link_23 = ""
        link_24 = ""
        link_25 = ""
        link_26 = ""
        link_27 = ""
        link_28 = ""
        link_29 = ""
        link_30 = ""
        link_31 = ""
        link_32 = ""
        link_33 = ""
        link_34 = ""
        link_35 = ""
        link_36 = ""
        link_37 = ""
        link_38 = ""
        link_39 = ""
        link_40 = ""
        link_41 = ""
        link_42 = ""
        link_43 = ""
        link_44 = ""
        link_45 = ""
        link_46 = ""
        link_47 = ""
        link_48 = ""
        link_49 = ""
        link_50 = ""
        link_51 = ""
        link_52 = ""
        link_53 = ""
        link_54 = ""
        link_55 = ""
        link_56 = ""
        link_57 = ""
        link_58 = ""
        link_59 = ""
        link_60 = ""
        link_61 = ""
        link_62 = ""
        link_63 = ""
        link_64 = ""
        link_65 = ""
        link_66 = ""
        link_67 = ""
        link_68 = ""
        link_69 = ""
        link_70 = ""
        link_71 = ""
        link_72 = ""
        link_73 = ""
        link_74 = ""
        link_75 = ""
        link_76 = ""
        link_77 = ""
        link_78 = ""
        link_79 = ""
        link_80 = ""
        link_81 = ""
        link_82 = ""
        link_83 = ""
        link_84 = ""
        link_85 = ""
        link_86 = ""
        link_87 = ""
        link_88 = ""
        link_89 = ""
        link_90 = ""
        link_91 = ""
        link_92 = ""
        link_93 = ""
        link_94 = ""
        link_95 = ""
        link_96 = ""
        link_97 = ""
        link_98 = ""
        link_99 = ""
        link_100 = ""

        #text holder for all the docs associated with environmental impact assessments
        EIAR_text = ""

        for case_element in case_elements:
    
            #kinds of case_elements
            #row_type = list of case details, not all types are present for all cases
            #   <p class="case-sub"> Description/Case type/Decision/Date signed/EIAR/NIS
            #   <p class="case-summary">
            #parties = open list of n parties
            #   <ul class="case-list">
            #   <li> <p> party
            #history = dates and status  
            #   <p class="case-sub">History</p> 
            #   <ul class="no-bullet">
            #   <li>
            #       <div class="medium-3 cell"> date
            #       <div class="medium-9 cell"> details
            #Documents 
            #   <ul class="">
            #   <a href=****>
            #or <p>The application is subject to an EIA procedure.</p>
            row_type =""
            row_type =case_element.find("p",class_="case-sub")

            if str(type(row_type)) != "<class 'NoneType'>" :
                row_type = row_type.text.strip()
                #For the first set of options the rows are in the standard format
                #For the remainder they are in some form of list and each have to 
                # be broken up separately

                #print(row_type)
                if row_type=="Description" :
                    row_details = case_element.find("p", class_="case-summary")
                    case_Description = row_details.text.strip()
                    #print("case_Description:"+case_Description)
                elif row_type=="Case type" :
                    row_details = case_element.find("p", class_="case-summary")
                    case_Type = row_details.text.strip()
                    #print("case_Type:"+case_Type)
                elif row_type=="Decision" :
                    row_details = case_element.find("p", class_="case-summary")
                    case_Decision = row_details.text.strip()
                    #print("case_Decision: "+case_Decision)
                elif row_type=="Date signed" :
                    row_details = case_element.find("p", class_="case-summary")
                    case_Date_Signed = row_details.text.strip()
                    #print("case_date_signed: "+case_Date_Signed)
                elif row_type=="EIAR" :
                    row_details = case_element.find("p", class_="case-summary")
                    case_EIAR = row_details.text.strip()
                    #print("case_EIAR: "+case_EIAR)
                elif row_type=="NIS" :
                    row_details = case_element.find("p", class_="case-summary")
                    case_NIS = row_details.text.strip()
                    #print("case_NIS: "+case_NIS)
                elif row_type=="Parties" :
                    #first of the lists
                    #list of parties, at least one undetermined what the max are
                    #broken up by: 
                    #   <ul class="case-list">
                    #   <li> <p> party
                    
                    row_details = case_element.find("ul", class_="case-list")
                    parties = row_details.find_all("li")

                    case_parties = len(parties)

                    if case_parties > 50: print("TOOO MANNY PARTIES")
                    track_party = 1

                    for party in parties:
                        this_party = party.text.strip() 
                        if track_party==1: party_1 = this_party
                        elif track_party==2: party_2 = this_party
                        elif track_party==3: party_3 = this_party
                        elif track_party==4: party_4 = this_party
                        elif track_party==5: party_5 = this_party
                        elif track_party==6: party_6 = this_party
                        elif track_party==7: party_7 = this_party
                        elif track_party==8: party_8 = this_party
                        elif track_party==9: party_9 = this_party
                        elif track_party==10: party_10 = this_party
                        elif track_party==11: party_11 = this_party
                        elif track_party==12: party_12 = this_party
                        elif track_party==13: party_13 = this_party
                        elif track_party==14: party_14 = this_party
                        elif track_party==15: party_15 = this_party
                        elif track_party==16: party_16 = this_party
                        elif track_party==17: party_17 = this_party
                        elif track_party==18: party_18 = this_party
                        elif track_party==19: party_19 = this_party
                        elif track_party==20: party_20 = this_party
                        elif track_party==21: party_21 = this_party
                        elif track_party==22: party_22 = this_party
                        elif track_party==23: party_23 = this_party
                        elif track_party==24: party_24 = this_party
                        elif track_party==25: party_25 = this_party
                        elif track_party==26: party_26 = this_party
                        elif track_party==27: party_27 = this_party
                        elif track_party==28: party_28 = this_party
                        elif track_party==29: party_29 = this_party
                        elif track_party==30: party_30 = this_party
                        elif track_party==31: party_31 = this_party
                        elif track_party==32: party_32 = this_party
                        elif track_party==33: party_33 = this_party
                        elif track_party==34: party_34 = this_party
                        elif track_party==35: party_35 = this_party
                        elif track_party==36: party_36 = this_party
                        elif track_party==37: party_37 = this_party
                        elif track_party==38: party_38 = this_party
                        elif track_party==39: party_39 = this_party
                        elif track_party==40: party_40 = this_party
                        elif track_party==41: party_41 = this_party
                        elif track_party==42: party_42 = this_party
                        elif track_party==43: party_43 = this_party
                        elif track_party==44: party_44 = this_party
                        elif track_party==45: party_45 = this_party
                        elif track_party==46: party_46 = this_party
                        elif track_party==47: party_47 = this_party
                        elif track_party==48: party_48 = this_party
                        elif track_party==49: party_49 = this_party
                        elif track_party==50: party_50 = this_party
                        elif track_party==51: party_51 = this_party
                        elif track_party==52: party_52 = this_party
                        elif track_party==53: party_53 = this_party
                        elif track_party==54: party_54 = this_party
                        elif track_party==55: party_55 = this_party
                        elif track_party==56: party_56 = this_party
                        elif track_party==57: party_57 = this_party
                        elif track_party==58: party_58 = this_party
                        elif track_party==59: party_59 = this_party
                        elif track_party==60: party_60 = this_party
                        elif track_party==61: party_61 = this_party
                        elif track_party==62: party_62 = this_party
                        elif track_party==63: party_63 = this_party
                        elif track_party==64: party_64 = this_party
                        elif track_party==65: party_65 = this_party
                        elif track_party==66: party_66 = this_party
                        elif track_party==67: party_67 = this_party
                        elif track_party==68: party_68 = this_party
                        elif track_party==69: party_69 = this_party
                        elif track_party==70: party_70 = this_party
                        elif track_party==71: party_71 = this_party
                        elif track_party==72: party_72 = this_party
                        elif track_party==73: party_73 = this_party
                        elif track_party==74: party_74 = this_party
                        elif track_party==75: party_75 = this_party
                        elif track_party==76: party_76 = this_party
                        elif track_party==77: party_77 = this_party
                        elif track_party==78: party_78 = this_party
                        elif track_party==79: party_79 = this_party
                        elif track_party==80: party_80 = this_party
                        elif track_party==81: party_81 = this_party
                        elif track_party==82: party_82 = this_party
                        elif track_party==83: party_83 = this_party
                        elif track_party==84: party_84 = this_party
                        elif track_party==85: party_85 = this_party
                        elif track_party==86: party_86 = this_party
                        elif track_party==87: party_87 = this_party
                        elif track_party==88: party_88 = this_party
                        elif track_party==89: party_89 = this_party
                        elif track_party==80: party_90 = this_party
                        elif track_party==91: party_91 = this_party
                        elif track_party==92: party_92 = this_party
                        elif track_party==93: party_93 = this_party
                        elif track_party==94: party_94 = this_party
                        elif track_party==95: party_95 = this_party
                        elif track_party==96: party_96 = this_party
                        elif track_party==97: party_97 = this_party
                        elif track_party==98: party_98 = this_party
                        elif track_party==99: party_99 = this_party
                        elif track_party==100: party_100 = this_party
                        else: print("BUSTED the number of parties:    " + str(track_party))

                        track_party = track_party + 1

                elif row_type=="History" :
                    #list of events, at least one, undetermined what the max are
                    #broken up by: 
                    #   <p class="case-sub">History</p> 
                    #   <ul class="no-bullet">
                    #   <li>
                    #       <div class="medium-3 cell"> date
                    #       <div class="medium-9 cell"> details

                    row_details = case_element.find("ul", class_="no-bullet")
                    events = row_details.find_all("li")

                    case_events = len(events)

                    if case_events > 10: print("TOOO MANNY Events")
                    track_events = 1

                    for event in events:
                        this_event = event.find("div", class_="medium-9 cell")
                        this_event = this_event.text.strip()
                        this_event_date = event.find("div", class_="medium-3 cell")
                        this_event_date = this_event_date.text.strip()
                        
                        if track_events==1: event_1 = this_event
                        elif track_events==2: event_2 = this_event
                        elif track_events==3: event_3 = this_event
                        elif track_events==4: event_4 = this_event
                        elif track_events==5: event_5 = this_event
                        elif track_events==6: event_6 = this_event
                        elif track_events==7: event_7 = this_event
                        elif track_events==8: event_8 = this_event
                        elif track_events==9: event_9 = this_event
                        elif track_events==10: event_10 = this_event
                        else: print("BUSTED the number of events:    " + str(track_events))

                        if track_events==1: event_1_date = this_event_date
                        elif track_events==2: event_2_date = this_event_date
                        elif track_events==3: event_3_date = this_event_date
                        elif track_events==4: event_4_date = this_event_date
                        elif track_events==5: event_5_date = this_event_date
                        elif track_events==6: event_6_date = this_event_date
                        elif track_events==7: event_7_date = this_event_date
                        elif track_events==8: event_8_date = this_event_date
                        elif track_events==9: event_9_date = this_event_date
                        elif track_events==10: event_10_date = this_event_date
                        else: print("BUSTED the number of events:    " + str(track_events))

                        track_events = track_events + 1

                elif row_type=="Documents" :
                    #Documents 
                    #   <ul class="">
                    #   <a href=****>
                    #or <p>The application is subject to an EIA procedure.</p>
                    # EIA <ul class="vertical menu accordion-menu" data-accordion-menu=""
                    #super long menu tree, not sure of the value of breaking it down, but keeping
                    #the data

                    if (case_EIAR=="Yes"):

                        row_details = case_element.find("ul", class_="vertical menu accordion-menu")
                        
                        EIAR_text = "The application is subject to an EIA procedure."
                        #EIAR_text = row_details
                        #EIAR_text = str(EIAR_text)
                        #print(EIAR_text)
                        #EIAR_text = EIAR_text.replace(",","###")
                        #print(EIAR_text)
                    
                    else: 
                        row_details = case_element.find("ul")
                        links = row_details.find_all("a")

                        track_links = 1
                        case_links = len(links)

                        for link in links:
                            this_link = link["href"]
                            #print(this_link)

                            if track_links==1: link_1 = this_link
                            elif track_links==2: link_2= this_link
                            elif track_links==3: link_3 = this_link
                            elif track_links==4: link_4 = this_link
                            elif track_links==5: link_5 = this_link
                            elif track_links==6: link_6 = this_link
                            elif track_links==7: link_7 = this_link
                            elif track_links==8: link_8 = this_link
                            elif track_links==9: link_9 = this_link
                            elif track_links==10: link_10 = this_link
                            elif track_links==11: link_11= this_link
                            elif track_links==12: link_12= this_link
                            elif track_links==13: link_13 = this_link
                            elif track_links==14: link_14 = this_link
                            elif track_links==15: link_15 = this_link
                            elif track_links==16: link_16 = this_link
                            elif track_links==17: link_17 = this_link
                            elif track_links==18: link_18 = this_link
                            elif track_links==19: link_19 = this_link
                            elif track_links==20: link_20 = this_link
                            elif track_links==21: link_21= this_link
                            elif track_links==22: link_22= this_link
                            elif track_links==23: link_23 = this_link
                            elif track_links==24: link_24 = this_link
                            elif track_links==25: link_25 = this_link
                            elif track_links==26: link_26 = this_link
                            elif track_links==27: link_27 = this_link
                            elif track_links==28: link_28 = this_link
                            elif track_links==29: link_29 = this_link
                            elif track_links==30: link_30 = this_link
                            elif track_links==31: link_31= this_link
                            elif track_links==32: link_32= this_link
                            elif track_links==33: link_33 = this_link
                            elif track_links==34: link_34 = this_link
                            elif track_links==35: link_35 = this_link
                            elif track_links==36: link_36 = this_link
                            elif track_links==37: link_37 = this_link
                            elif track_links==38: link_38 = this_link
                            elif track_links==39: link_39 = this_link
                            elif track_links==40: link_40 = this_link
                            elif track_links==41: link_41= this_link
                            elif track_links==42: link_42= this_link
                            elif track_links==43: link_43 = this_link
                            elif track_links==44: link_44 = this_link
                            elif track_links==45: link_45 = this_link
                            elif track_links==46: link_46 = this_link
                            elif track_links==47: link_47 = this_link
                            elif track_links==48: link_48 = this_link
                            elif track_links==49: link_49 = this_link
                            elif track_links==50: link_50 = this_link
                            elif track_links==51: link_51= this_link
                            elif track_links==52: link_52= this_link
                            elif track_links==53: link_53 = this_link
                            elif track_links==54: link_54 = this_link
                            elif track_links==55: link_55 = this_link
                            elif track_links==56: link_56 = this_link
                            elif track_links==57: link_57 = this_link
                            elif track_links==58: link_58 = this_link
                            elif track_links==59: link_59 = this_link
                            elif track_links==60: link_60 = this_link
                            elif track_links==61: link_61= this_link
                            elif track_links==62: link_62= this_link
                            elif track_links==63: link_63 = this_link
                            elif track_links==64: link_64 = this_link
                            elif track_links==65: link_65 = this_link
                            elif track_links==66: link_66 = this_link
                            elif track_links==67: link_67 = this_link
                            elif track_links==68: link_68 = this_link
                            elif track_links==69: link_69 = this_link
                            elif track_links==70: link_70 = this_link
                            elif track_links==71: link_71= this_link
                            elif track_links==72: link_72= this_link
                            elif track_links==73: link_73 = this_link
                            elif track_links==74: link_74 = this_link
                            elif track_links==75: link_75 = this_link
                            elif track_links==76: link_76 = this_link
                            elif track_links==77: link_77 = this_link
                            elif track_links==78: link_78 = this_link
                            elif track_links==79: link_79 = this_link
                            elif track_links==80: link_80 = this_link
                            elif track_links==81: link_81= this_link
                            elif track_links==82: link_82= this_link
                            elif track_links==83: link_83 = this_link
                            elif track_links==84: link_84 = this_link
                            elif track_links==85: link_85 = this_link
                            elif track_links==86: link_86 = this_link
                            elif track_links==87: link_87 = this_link
                            elif track_links==88: link_88 = this_link
                            elif track_links==89: link_89 = this_link
                            elif track_links==90: link_90 = this_link
                            elif track_links==91: link_91= this_link
                            elif track_links==92: link_92= this_link
                            elif track_links==93: link_93 = this_link
                            elif track_links==94: link_94 = this_link
                            elif track_links==95: link_95 = this_link
                            elif track_links==96: link_96 = this_link
                            elif track_links==97: link_97 = this_link
                            elif track_links==98: link_98 = this_link
                            elif track_links==99: link_99 = this_link
                            elif track_links==100: link_100 = this_link
                            else: print("BUSTED the number of documents:    " + str(track_links))


                            track_links = track_links +1

        row =[
                    application_id,
                   case_reference,
                    case_address,
                    case_council,
                    case_Description,
                    case_Type,
                    case_Decision,
                    case_Date_Signed,
                    case_EIAR,
                    case_NIS,
                    case_parties,
                    party_1,
                    party_2,
                    party_3,
                    party_4,
                    party_5,
                    party_6,
                    party_7,
                    party_8,
                    party_9,
                    party_10,
                    party_11,
                    party_12,
                    party_13,
                    party_14,
                    party_15,
                    party_16,
                    party_17,
                    party_18,
                    party_19,
                    party_20,
                    party_21,
                    party_22,
                    party_23,
                    party_24,
                    party_25,
                    party_26,
                    party_27,
                    party_28,
                    party_29,
                    party_20,
                    party_31,
                    party_32,
                    party_33,
                    party_34,
                    party_35,
                    party_36,
                    party_37,
                    party_38,
                    party_39,
                    party_40,
                    party_41,
                    party_42,
                    party_43,
                    party_44,
                    party_45,
                    party_46,
                    party_47,
                    party_48,
                    party_49,
                    party_50,
                    party_51,
                    party_52,
                    party_53,
                    party_54,
                    party_55,
                    party_56,
                    party_57,
                    party_58,
                    party_59,
                    party_60,
                    party_61,
                    party_62,
                    party_63,
                    party_64,
                    party_65,
                    party_66,
                    party_67,
                    party_68,
                    party_69,
                    party_70,
                    party_71,
                    party_72,
                    party_73,
                    party_74,
                    party_75,
                    party_76,
                    party_77,
                    party_78,
                    party_79,
                    party_80,
                    party_81,
                    party_82,
                    party_83,
                    party_84,
                    party_85,
                    party_86,
                    party_87,
                    party_88,
                    party_89,
                    party_90,
                    party_91,
                    party_92,
                    party_93,
                    party_94,
                    party_95,
                    party_96,
                    party_97,
                    party_98,
                    party_99,
                    party_100,
                    event_1,
                    event_2,
                    event_3,
                    event_4,
                    event_5,
                    event_6,
                    event_7,
                    event_8,
                    event_9,
                    event_10,
                    event_1_date,
                    event_2_date,
                    event_3_date,
                    event_4_date,
                    event_5_date,
                    event_6_date,
                    event_7_date,
                    event_8_date,
                    event_9_date,
                    event_10_date,
                    case_links,
                    link_1,
                    link_2,
                    link_3,
                    link_4,
                    link_5,
                    link_6,
                    link_7,
                    link_8,
                    link_9,
                    link_10,
                    link_11,
                    link_12,
                    link_13,
                    link_14,
                    link_15,
                    link_16,
                    link_17,
                    link_18,
                    link_19,
                    link_20,
                    link_21,
                    link_22,
                    link_23,
                    link_24,
                    link_25,
                    link_26,
                    link_27,
                    link_28,
                    link_29,
                    link_30,
                    link_31,
                    link_32,
                    link_33,
                    link_34,
                    link_35,
                    link_36,
                    link_37,
                    link_38,
                    link_39,
                    link_40,
                    link_41,
                    link_42,
                    link_43,
                    link_44,
                    link_45,
                    link_46,
                    link_47,
                    link_48,
                    link_49,
                    link_50,
                    link_51,
                    link_52,
                    link_53,
                    link_54,
                    link_55,
                    link_56,
                    link_57,
                    link_58,
                    link_59,
                    link_60,
                    link_61,
                    link_62,
                    link_63,
                    link_64,
                    link_65,
                    link_66,
                    link_67,
                    link_68,
                    link_69,
                    link_70,
                    link_71,
                    link_72,
                    link_73,
                    link_74,
                    link_75,
                    link_76,
                    link_77,
                    link_78,
                    link_79,
                    link_80,
                    link_81,
                    link_82,
                    link_83,
                    link_84,
                    link_85,
                    link_86,
                    link_87,
                    link_88,
                    link_89,
                    link_90,
                    link_91,
                    link_92,
                    link_93,
                    link_94,
                    link_95,
                    link_96,
                    link_97,
                    link_98,
                    link_99,
                    link_100,
                    page_description
                ]
        writer.writerow(row)
        case_number = case_number -1
        #if case_number == 301545: case_number = 301544
        #if case_number == 315005: case_number = 315004


             
    else: 
        bad_files = bad_files + 1
        bad_numbers_writer.writerow(str(case_number))
        case_number = case_number -1
        #if case_number == 301545: case_number = 301544
        #if case_number == 315005: case_number = 315004
        






