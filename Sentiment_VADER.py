
import pandas as pd

# Load data
df = pd.read_excel('/Users/milinzhang/Documents/05_2023Fall_Masterarbeit/senti_py/senti_sample_en.xlsx')

from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer

# Initialize the SentimentIntensityAnalyzer
analyzer = SentimentIntensityAnalyzer()

# Apply sentiment analysis to the 'text' column
df['senti_vader'] = df['text'].apply(lambda x: analyzer.polarity_scores(x)['compound'])

df.to_excel('/Users/milinzhang/Documents/05_2023Fall_Masterarbeit/senti_py/senti_result_vader.xlsx', index=False, sheet_name='Sheet1')
