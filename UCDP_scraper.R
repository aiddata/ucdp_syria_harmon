#http://ucdp.uu.se/api/events/211473

#install.packages("rjson")
library(rjson)

#json_file <- "http://ucdp.uu.se/api/events/211474"
#conflict.dta <- fromJSON(paste(readLines(json_file), collapse=""))


#start_id = 9396
#end_id = 209499

start_id = 211470
end_id = 211480
found_data = 0

for(current_id in start_id:end_id)
{
  conflict.url <- paste("http://ucdp.uu.se/api/events/",current_id,sep="")
  conflict.dta <- fromJSON(paste(readLines(conflict.url), collapse=""))
  
  if(length(conflict.dta) > 0)
  {
    if(conflict.dta[[1]]$country == "Syria")
    {
      print("This is Syria")
        if(found_data == 0)
        {
          conflict.dta[[1]]$query_id <- current_id
          SyriaData <- conflict.dta[[1]]
          found_data = 1
        }
      else
        {
          conflict.dta[[1]]$query_id <- current_id
          SyriaData <- rbind(SyriaData,conflict.dta[[1]])
        }

    } else {
      print("Not Syria")
    }
  }
  else
  {
    print("There was no data!")
  }
}

write.csv(SyriaData, "SyriaData.csv")
