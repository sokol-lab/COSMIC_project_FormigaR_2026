



a = lapply(list.files(path = "../humann3_path_coverage/relab_normed/", full.names = T), 
       function(x){ 
           tmp <- read_tsv(x, col_names = T, show_col_types = F)
           tmp <- tmp %>% filter(!grepl(`# Pathway`, pattern = "UN[A-Z]+")) %>% filter(!grepl(`# Pathway`, pattern = "\\|"))
           id = colnames(tmp)[2] %>% str_remove(pattern = "_Abundance-RELAB") %>% str_remove(pattern = "CRSAFR-001-")
           if(grepl(id, pattern = "^[0-9]")){
               id <- paste0("HD_", id)
           }
           colnames(tmp) <- c("pathway", id)
           return(tmp)
       }) 

a = a %>% purrr::reduce(., .f = full_join)
a[is.na(a)] <- 0

write_tsv(a, file = "../data/HUMAnN3_pathabundance_relab.tsv")
