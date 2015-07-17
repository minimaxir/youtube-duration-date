source("Rstart.R")

ma_days <- 30

df <- read_csv("youtube_duration_date.csv") %>%
	
	# Need to override filter() so we don't use dplyr's
	mutate(ma_duration = stats::filter(avg_duration, rep(1/ma_days, ma_days), sides=1))

# Remove first 30 entries since no MA, and remove last 2 entries
df <- df[-c(1:ma_days, nrow(df) - 0:2),]

plot <- ggplot(df, aes(x=as.Date(day), y=ma_duration)) +
	geom_line(color="#e74c3c") +
	scale_x_date(breaks = "1 year", labels=date_format("%Y")) +
	scale_y_continuous(breaks = seq(0,1080, by=60), labels = sprintf("%dm", 0:18)) +
	fte_theme() +
	geom_vline(xintercept=as.numeric(as.Date("2010-07-29")), size=0.20, color="#1a1a1a", alpha=1, linetype="dashed") +
	annotate(geom="text", label = "July 29th, 2010\nTime Limit Increased from 10m to 15m", x=as.Date("2010-07-29") - 30, y=Inf, vjust=1.8, size=2, hjust=1, family="Avenir Next Condensed Regular", color="#1a1a1a", alpha=1) +
	geom_vline(xintercept=as.numeric(as.Date("2010-12-09")), size=0.20, color="#1a1a1a", alpha=1, linetype="dashed") +
	annotate(geom="text", label = "December 9th, 2010\nTime Limit Removed", x=as.Date("2010-12-09") + 45, y=Inf, vjust=1.8, size=2, hjust=0, family="Avenir Next Condensed Regular", color="#1a1a1a", alpha=1) +
	labs(x = "Date of Video Submission to YouTube", y="30-Day Moving Average of Daily Average Video Length", title="Impact of YouTube 15-Minute Video Time Limit Removal on Average YouTube Video Length")

max_save(plot, "youtube_duration_time", "YouTube API", w=6, h=3.5)
