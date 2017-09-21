\name{qlearningupdate}
\alias{qlearningupdate}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ qlearningupdate
}
\description{
  This repository implements \href{http://artint.info/html/ArtInt_265.html}{Q-Learning}, a model-free form of reinforcement learning in R.
}
\usage{
qlearningupdate(q, currentstate, currentaction, currentreward, nextstate=NULL,
  rewardcount=.5, gamma=.25)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{q
}{Input state/action matrix.}
  \item{currentstate
}{Current state of the game. Does not have to match any of the state for \emph{q}.}
\item{currentaction
}{Action to take.}
\item{currentreward
}{Reward for \emph{currentaction} in current iteration.}
\item{nextstate
}{State that the game is in after taking \emph{currentaction}.}
\item{rewardcount
}{Regularization constant for reward.}
\item{gamma
}{Learning rate constant for Q-Learning.}
}
\details{
For internal use for \emph{qlearn}.
}
\value{
An updated state/action matrix.
}
\references{
http://labressler.github.io/analytics
}
\author{
Liam Bressler
%%  ~~who you are~~
}
\note{
Contact at liam.bressler@yale.edu
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~
\examples{

cardgame <- function()
{
  playercards <- sample(1:8,4) #distribute the cards, we're player one
  ourcard <- playercards[1] #our card
  playertotals <- rep(-1,4) #including the antes
  playersinpot <- vector()
  for (player in 2:4) #other 3 players go first
  {
    if (playercards[player]>=2)
    {
      playertotals[player] <- (-3)
      playersinpot <- append(playersinpot,player)
    }
  }
  #the next line is where we want to choose our action
  player1 <- 'Choose'
  if (player1=="Call")
  {
    playertotals[1] <- (-3)
    playersinpot <- append(playersinpot,1)
  }
  potsize <- -1*(sum(playertotals)) #the amount in the pot is how much the players put in
  playercards[!(1:4 \%in\% playersinpot)] <- 0 #get rid of everyone who folded
  winner <- which.max(playercards) #winner is the person with the highest card who didn't fold
  playertotals[winner] <- playertotals[winner]+potsize
  return(playertotals[1]) #return how much we won
}

strat <- qlearn(game="cardgame",statevars="ourcard",possibleactions=c("Call","Fold"),
  playername="player1",numiter=25000) #make sure each function and variable name is a string

strat <- qlearningupdate(strat,currentstate=7,currentaction="Call",currentreward=5)
#Update the matrix after an example when we call with the 7 card as our state, winning 5 chips
}
%%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%%}
%%\examples{


%%}


% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ reinforcementlearning }% use one of  RShowDoc("KEYWORDS")
\keyword{ machinelearning }% __ONLY ONE__ keyword per line
\keyword{ optimize }
