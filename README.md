# 🔢 16-Bit Decimal to Hex Converter (Assembly)

A low-level **System Utility** written in **x86 Assembly Language (MASM/TASM)**. This program operates in Real Mode (16-bit) to accept a standard Decimal integer (0-65535) from the user, validates the input, and calculates its Hexadecimal equivalent using bitwise rotation.



## 🚀 Features

* **Input Validation:** Automatically checks if input characters are digits (`0-9`). If a non-digit is entered, it displays an error message and exits safely.
* **Range Support:** Handles 16-bit unsigned integers (values up to 65535).
* **Bitwise Output Logic:** Uses nibble processing (4-bit chunks) to generate the hex string, ensuring efficient performance without complex division.
* **Modular Code:** Separated into `INPUT` and `OUTPUT` procedures for readability.

## 🛠️ Internal Logic & Register Usage

The program manipulates specific CPU registers to handle the conversion:

| Register | Purpose in Code |
| :--- | :--- |
| **AX** | **Arithmetic:** Used for the `MUL` operation (multiplying current total by 10) during input reading. |
| **BX** | **Storage/Shifter:** Holds the final binary value. During output, this register is shifted left (`SHL`) 4 times per loop to isolate the next hex digit. |
| **CX** | **Counter:** Set to `4` during output to iterate through the 4 nibbles (hex digits) of a 16-bit number. |
| **DL** | **Character Buffer:** Holds the single digit being printed. Logic is applied here to determine if it needs a numeric offset (`+30H`) or alpha offset (`+37H`). |

### The Conversion Algorithm
1.  **Decimal to Binary (Input Phase):**
    * Read char `AL`.
    * Validate (Jump to error if `< '0'` or `> '9'`).
    * Multiply current `NUM` by 10.
    * Add new digit to `NUM`.
2.  **Binary to Hex (Output Phase):**
    * Load number into `BX`.
    * **Isolate High Nibble:** Copy `BH` to `DL` and Shift Right (`SHR`) by 4.
    * **ASCII Convert:**
        * If value $\le 9$: Add `30H` ('0').
        * If value $> 9$: Add `37H` (Converts 10 $\rightarrow$ 'A').
    * **Next Nibble:** Shift the whole number in `BX` Left (`SHL`) by 4 to bring the next digit into position.

## 💻 How to Run

Since this is 16-bit Assembly, you need an emulator like **DOSBox** or **emu8086** and an assembler like **MASM** or **TASM**.

#### 1. Prerequisites
Install **emu8086**.

#### 2. Assemble and Link
Mount your file in emu8086.

#### 3. Execution
Run the file.

## 📝 Example Usage
#### Scenario 1: Standard Conversion
```text
Enter decimal number (0-65535): 255
Hexadecimal equivalent: 00FF
```

#### Scenario 2: Large Number
```text
Enter decimal number (0-65535): 65535
Hexadecimal equivalent: FFFF
```

#### Scenario 3: Error Handling
```text
Enter decimal number (0-65535): 12A
Invalid input! Enter digits 0-9 only
```

## ⚠️ Requirements
  * **Assembler:** MASM (Microsoft Macro Assembler) or TASM.
  * **Emulator:** DOSBox/emu8086 (Required for 64-bit Windows/Linux/Mac).
  * **Architecture:** x86 Real Mode (16-bit).
