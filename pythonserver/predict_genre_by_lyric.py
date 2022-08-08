from flask import Flask, request, jsonify
from tensorflow import keras
import numpy as np
# import jsonify
import json

from konlpy.tag import Okt
okt = Okt()

app = Flask(__name__)

@app.route('/predictgenrebylstm', methods=['get'])
def predict_genre_by_dl():
    # parameter로 넘어온 lyric을 받습니다.
    lyric = request.args.get('lyric')

    # Null Check와 Empyt 체크를 합니다.
    if lyric is None or lyric == '':
        return jsonify({'result': '가사가 입력되지 않았습니다. - No parameter'})

    else:
        # 저장한 모델을 로드합니다.
        model = keras.models.load_model('data/predict_genre_by_lstm.h5')

        # Load the token-to-index dictionary
        with open('data/token_to_index.json') as f:
            index_dict = json.load(f)['0']
            input_tokenized = okt.nouns(lyric)

            input_indexed = []

            # Convert the tokens to their index values
            for t in input_tokenized:
                if t in index_dict:
                    input_indexed.append(index_dict[t])

            input_indexed = np.array([input_indexed])

            # pad to 105
            input_padded = keras.preprocessing.sequence.pad_sequences(input_indexed, maxlen=105, padding='post')

            pred = model.predict(input_padded)
            genre_list = ['발라드', '댄스', '힙합', '트로트']

            # Get the index of the highest probability
            genre = genre_list[np.argmax(pred)]

        return genre


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000, debug=True)