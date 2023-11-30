from transformers import AutoModelForSequenceClassification
from transformers import TFAutoModelForSequenceClassification
from transformers import AutoTokenizer, AutoConfig
import numpy as np
import pandas as pd
from scipy.special import softmax

# Load the dataset
df = pd.read_excel("/Users/milinzhang/Documents/05_2023Fall_Masterarbeit/senti_py/senti_sample_en.xlsx")

# Preprocess text (username and link placeholders)
def preprocess(text):
    new_text = []
    for t in text.split(" "):
        t = '@user' if t.startswith('@') and len(t) > 1 else t
        t = 'http' if t.startswith('http') else t
        new_text.append(t)
    return " ".join(new_text)

task='sentiment'
MODEL = f"cardiffnlp/twitter-roberta-base-{task}"

# tokenizer = AutoTokenizer.from_pretrained(MODEL)
tokenizer = AutoTokenizer.from_pretrained("cardiffnlp/twitter-roberta-base")

# # PT
# model = AutoModelForSequenceClassification.from_pretrained(MODEL)
# model.save_pretrained(MODEL)

# text = "We didn’t realise, at first, that the plants were singing. We mistook the sound for a scream.My British Science Fiction Association longlisted story, The Sound, can be read for free here:  story is included in Possible Worlds and Other Stories"
# text = preprocess(text)
# encoded_input = tokenizer(text, return_tensors='pt')
# output = model(**encoded_input)
# scores = output[0][0].detach().numpy()
# scores = softmax(scores)

# TF
model = TFAutoModelForSequenceClassification.from_pretrained(MODEL)
model.save_pretrained(MODEL)
# text = "Covid cases are increasing fast!"
# encoded_input = tokenizer(text, return_tensors='tf')
# output = model(encoded_input)
# scores = output[0][0].numpy()
# scores = softmax(scores)
#
# # Print labels and scores
# ranking = np.argsort(scores)
# ranking = ranking[::-1]
# for i in range(scores.shape[0]):
#     l = config.id2label[ranking[i]]
#     s = scores[ranking[i]]
#     print(f"{i+1}) {l} {np.round(float(s), 4)}")

# Load label mapping from the model's configuration
labels = model.config.id2label.values()

# # Iterate over the dataframe
# for index, row in df.iterrows():
#     text = row['text']
#     text = preprocess(text)
#     encoded_input = tokenizer(text, return_tensors='tf', max_length=511, truncation=True)
#     output = model(**encoded_input)
#     scores = output.logits[0].numpy()
#     scores = softmax(scores)
#
#     # Find the index of the maximum score
#     max_index = np.argmax(scores)
#
#     # Get the corresponding sentiment label
#     max_sentiment_label = list(labels)[max_index]
#
#     # Save the label with the maximum score in the 'senti_roberta' column
#     df.at[index, 'senti_roberta'] = max_sentiment_label

# Iterate over the dataframe
for index, row in df.iterrows():
    text = row['text']
    text = preprocess(text)
    encoded_input = tokenizer(text, return_tensors='tf', max_length=511, truncation=True)
    output = model(**encoded_input)
    scores = output.logits[0].numpy()
    scores = softmax(scores)

# Get the label with highest score
    # # Find the index of the maximum score
    # max_index = np.argmax(scores)
    #
    # # Get the corresponding sentiment label and score
    # max_sentiment_label = list(labels)[max_index]
    # max_score = scores[max_index]
    #
    # # Save the label with the maximum score in the 'label' column
    # df.at[index, 'label'] = max_sentiment_label
    #
    # # Save the maximum score in the 'score' column
    # df.at[index, 'score'] = max_score

# Get all the labels and scores
    # Get the sentiment labels and scores
    sentiment_labels = list(labels)
    sentiment_scores = scores.tolist()

    # Save each sentiment label and score in separate columns
    for label, score in zip(sentiment_labels, sentiment_scores):
        df.at[index, label] = score

df.to_excel('/Users/milinzhang/Documents/05_2023Fall_Masterarbeit/senti_py/senti_result_twiRoBERTa_all.xlsx', index=False, sheet_name='Sheet1')
