//Truy van 1:
SELECT
    a.Category,
    SUM(r.Sentiment_Subjectivity) AS SUM_Sentiment_Subjectivity,
    SUM(r.Sentiment_Polarity) AS SUM_Sentiment_Polarity
FROM
    dbo.review r
        JOIN dbo.app a ON r.App = a.App
GROUP BY
    a.Category;

//Truy van 2:
SELECT
    a.Category,
    SUM(CASE WHEN r.Sentiment = 'Positive'  THEN 1 ELSE 0 END) AS Positive_Count,
    SUM(CASE WHEN r.Sentiment = 'Negative'  THEN 1 ELSE 0 END) AS Negative_Count,
    SUM(CASE WHEN r.Sentiment = 'Neutral'  THEN 1 ELSE 0 END) AS Neutral_Count
FROM
    dbo.review r
        JOIN dbo.app a ON r.App = a.App
GROUP BY
    a.Category;

//Truy vấn 3:

ALTER TABLE app
ALTER COLUMN Price float
ALTER COLUMN Rating float

SET STATISTICS TIME ON;
SELECT TOP 1
    a.Category,
    SUM(LEN(r.Translated_Review) - LEN(REPLACE(r.Translated_Review, ' ', '')) + 1) AS WordCount,
    AVG(a.Rating) AS Avg_Rating,
    AVG(a.Price) AS Avg_Price
FROM
    review AS r
        INNER JOIN app AS a ON r.app = a.app
GROUP BY
    a.Category
ORDER BY WordCount DESC
 SET STATISTICS TIME OFF;