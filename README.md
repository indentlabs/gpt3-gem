# gpt-3-gem

An easy interface for interacting with OpenAI from Ruby or Ruby on Rails.

## Configuration

Setup is easy. Just set your OpenAI Secret Key in an `OPENAI_SK` environment variable.

    export OPENAI_SK=<your key here>

## Usage

To generate a prompt completion, use the `Completion` class. For example,

    GPT3::Completion.create("Once upon a midnight dreary,",
      max_tokens: 512,
      engine: 'davinci',
      temperature: 0.5,
      n: 1,
      stop: nil
    )

Please see OpenAI's docs for what each parameter does. You can also pass `verbose: true` for some debug output that prints the original prompt and params.