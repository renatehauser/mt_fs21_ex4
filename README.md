# mt_fs21_ex4

This repo is just a collection of scripts showing how to install [JoeyNMT](https://github.com/joeynmt/joeynmt), download
data and train & evaluate models.

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps

Clone this repository in the desired place:

    git clone https://github.com/lucasseiler/mt_fs21_ex4

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software:

    ./scripts/download_install_packages.sh

Download data:

    ./scripts/download_preprocessed_data.sh

Train a model:

    ./scripts/train.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Evaluate a trained model with

    ./scripts/evaluate.sh
    
    
# Findings

## BLEU results

| Model | deen_transformer_regular | deen_transformer_layerdrop | deen_transformer_small |
| ----- | ------------------------ | -------------------------- | ---------------------- |
| all   | 11.0                     | 8.7                        |                   10.7 |
| [0,3] | 3.9                      | 8.6
| [1,2] | 0.2                      | 8.1

Looking only at the results of the deen_transformer_layerdrop model, one can see that there is only a slight decrease
when using only the first and the last layer instead of all. This is expected, as the layers needed to generalize during
training due to the rather high layerdrop probability. This small decrease is especially striking when comparing to the 
evaluation results of the deen_transformer_regular model. Here the quality of the translation dropped drastically from 11.0
to 3.9 BLEU points when only using the first and the last encoder layer. Even more striking is the difference between the
models with active layers 1 and 2. Here the BLEU score for the regular model is only slighly higher than 0, while in the
layerdrop model the BLEU score only decreased by 0.6 points.
This shows very nicely, that the layerdrop had the intended generalizing effect, so that the model with only parts of the 
encoder layers being active are able to produce almost equally good translations. However, the BLEU score when using all encoder layers
is also lower in the layerdrop model than in the model without layerdrop. The high layerdrop probability prevents the model
from adapting equally well to the data as the regular model, so this result is not surprising.

Adding a dropout probability to the model would further improve the generalization of the layers.


