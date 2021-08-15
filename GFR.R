library(plumber)
library(ggplot2)

#* @post /gfr
function(req){
  age <- as.numeric(req$body$age)
  sex <- as.factor(req$body$sex)
  wt <- as.numeric(req$body$wt)
  cr <- as.numeric(req$body$cr)
  gfr <- ((140-age)*wt)/(72*cr)
  if (sex == 'm') {
    gfr <- gfr * 1
  } else if ( sex == 'f') {
    gfr <- gfr * 0.85
  }
    return(gfr)
}

#* @serializer png
#* @get /plt
function(req){

  age <- as.numeric(req$args$age)
  sex <- as.factor(req$args$sex)
  wt <- as.numeric(req$args$wt)
  cr <- as.numeric(req$args$cr)
  gfr <- ((140-age)*wt)/(72*cr)
  if (sex == 'm') {
    gfr <- gfr * 1
  } else if ( sex == 'f') {
    gfr <- gfr * 0.85
  }
  
  sq <- seq(1,5, by=0.1)
  gs <- ((140-age)*wt)/(72*sq)
  if (sex == 'm') {
    gs <- gs * 1
    } else if (sex == 'f') {
      gs <- gs * 0.85
    }
  df<- data.frame(sq,gs)
  print(ggplot(data= df, aes(x=sq, y=gs)) +
          geom_line(color="purple") +
          geom_point(x=cr , y= gfr, color = "red") +
          xlab('Cr.') +
          ylab('eGFR')
        )
}
