DECLARE @word TABLE (word NVARCHAR(50))
DECLARE @count TABLE (word NVARCHAR(50), count INT)

DECLARE word_cursor CURSOR FOR
SELECT mess
FROM messages

DECLARE @mess NVARCHAR(50)

OPEN word_cursor

FETCH NEXT FROM word_cursor INTO @mess

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO @word
    SELECT value
    FROM STRING_SPLIT(@mess, ' ')

    FETCH NEXT FROM word_cursor INTO @mess
END

CLOSE word_cursor
DEALLOCATE word_cursor

INSERT INTO @count
SELECT word, COUNT(*)
FROM @word
GROUP BY word

SELECT TOP 10 * 
FROM @count 
ORDER BY count DESC
