plotLearningCurve <- function(m, train_plot, test_plot, title, xlab, ylab, rnge=range(0, 0.15)){
  plot(m, train_plot, type="l", col="red", xlab=NA, ylab=NA, ylim=rnge);
  par(new=TRUE);
  plot(m, test_plot, type="l", col="green", xlab=NA, ylab=NA, ylim=rnge, axes=FALSE);
  par(new=TRUE);
  legend('topright', c("Training", "C.V"),  
         bty="n", lty=1, lwd=0.5, cex=0.5,
         col=c('red', 'green'));
  
  title(title, 
        xlab=xlab,
        ylab=ylab);
}  