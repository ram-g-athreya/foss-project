plotLearningCurve <- function(m, train_plot, test_plot, title, xlab, ylab, rnge=range(0, 0.4)){
  plot(m, train_plot, type="l", col="red", xlab=NA, ylab=NA, ylim=rnge);
  par(new=TRUE);
  plot(m, test_plot, type="l", col="green", xlab=NA, ylab=NA, ylim=rnge, axes=FALSE);
  title(title, 
        xlab=xlab,
        ylab=ylab);
}  