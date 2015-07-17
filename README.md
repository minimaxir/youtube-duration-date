# youtube-duration-date
Code and data needed to reproduce The Relationship Between YouTube Video Category and Length of the Video

![](http://i.imgur.com/KY3xx1n.png)

Data obtained from my scraped database of YouTube submission metadata with this SQL query:
	
	SELECT to_char(date_published, 'YYYY-MM-DD')  AS day,
		COUNT(date_published) AS num_videos,
		AVG(duration) as avg_duration,
		STDDEV(duration) / SQRT(COUNT(duration)) AS se_duration,
		MEDIAN(duration) as med_duration
	FROM yt_videos
	GROUP BY day
	ORDER BY day


Requires packages declared at beginning of *Rstart.R*. Fonts will only render if code is run on OS X.