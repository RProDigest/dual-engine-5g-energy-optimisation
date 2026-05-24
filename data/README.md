# Data dictionary

This folder documents the dataset used in this project on AI/ML-based 5G energy consumption modelling.

## Data source

The data used in this project was obtained from the Zindi competition page:

> Zindi. (2023). *AI/ML for 5G energy consumption modelling: Data*.  
> https://zindi.africa/competitions/aiml-for-5g-energy-consumption-modelling/data

Please refer to the original Zindi competition page for the official data description, access conditions, and any usage restrictions.

## Dataset overview

The project uses three CSV files:

| File | Rows | Columns | Description |
|---|---:|---:|---|
| `BSinfo.csv` | 1,217 | 8 | Base station and cell configuration information |
| `CLdata.csv` | 125,575 | 10 | Hour-level cell counters, including traffic load and energy-saving mode activation indicators |
| `ECdata.csv` | 92,629 | 3 | Hour-level energy consumption measurements for base stations |

The uploaded files used in this project contained no missing values.

## File descriptions

### `BSinfo.csv`

`BSinfo.csv` contains configuration information for base stations and cells.

| Column | Description |
|---|---|
| `BS` | Name of the base station |
| `CellName` | Name of the cell |
| `RUType` | Radio unit type |
| `Mode` | Transmission mode |
| `Frequency` | Frequency of the cell |
| `Bandwidth` | Bandwidth of the cell |
| `Antennas` | Number of antennas of the base station |
| `TXpower` | Maximum transmit power of the cell |

### `CLdata.csv`

`CLdata.csv` contains hour-level cell measurements. These include service-related counters, such as cell load, and energy-saving mode counters, such as the intensity or duration of energy-saving mode activation.

| Column | Description |
|---|---|
| `Time` | Date and time at which the measurement was collected |
| `BS` | Name of the base station |
| `CellName` | Name of the cell |
| `load` | Load of the cell, with values in the range `[0, 1]` |
| `ESMode1` | Activation intensity of energy-saving mode 1, with values in the range `[0, 1]` |
| `ESMode2` | Activation intensity of energy-saving mode 2, with values in the range `[0, 1]` |
| `ESMode3` | Activation intensity of energy-saving mode 3, with values in the range `[0, 1]` |
| `ESMode4` | Activation indicator or intensity of energy-saving mode 4 |
| `ESMode5` | Activation intensity of energy-saving mode 5, with values in the range `[0, 1]` |
| `ESMode6` | Activation intensity of energy-saving mode 6, with values in the range `[0, 1]` |

### `ECdata.csv`

`ECdata.csv` contains hour-level energy consumption measurements for each base station.

| Column | Description |
|---|---|
| `Time` | Date and time at which the measurement was collected |
| `BS` | Name of the base station |
| `Energy` | Energy consumption measurement |

## Relationship between files

The three files can be linked using the following keys:

| Merge relationship | Recommended key columns |
|---|---|
| `CLdata.csv` with `BSinfo.csv` | `BS`, `CellName` |
| `CLdata.csv` with `ECdata.csv` | `Time`, `BS` |

A typical modelling workflow is:

1. Load `BSinfo.csv`, `CLdata.csv`, and `ECdata.csv`.
2. Merge cell-level counters with base station configuration data.
3. Merge the resulting dataset with energy consumption measurements.
4. Engineer time-based features from `Time`, such as hour of day.
5. Use load, configuration, and energy-saving mode variables to model or optimise energy consumption.

## Suggested folder structure

```text
data/
├── raw/
│   ├── BSinfo.csv
│   ├── CLdata.csv
│   └── ECdata.csv
├── processed/
│   └── merged_5g_energy_dataset.csv
└── README.md
```

## Reproducibility notes

- The raw data should be kept unchanged in `data/raw/`.
- Any cleaned, merged, or feature-engineered datasets should be saved separately in `data/processed/`.
- If the raw competition data cannot be redistributed publicly, keep the CSV files out of the GitHub repository and provide instructions for downloading them from Zindi.
- Use `.gitignore` to exclude large or restricted raw data files where necessary.

Example `.gitignore` entries:

```gitignore
data/raw/*.csv
data/processed/*.csv
```

## Citation

If this dataset is used in academic writing, cite the source as:

Zindi. (2023). *AI/ML for 5G energy consumption modelling: Data*. https://zindi.africa/competitions/aiml-for-5g-energy-consumption-modelling/data

In-text citation:

- Parenthetical: `(Zindi, 2023)`
- Narrative: `Zindi (2023)`

## Disclaimer

This repository is not the official source of the dataset. The official data source is the Zindi competition page listed above.
