#pragma once
#include <string>
class Complex {
    double real_ = 0, imag_ = 0;
    static Complex FromWide(long double real, long double imag);
    static int live_;
public:
    Complex();
    Complex(double real, double imag);
    Complex(const Complex& other);
    Complex& operator=(const Complex&) = default;
    ~Complex() noexcept;
    static int Live();
    void Init(double real, double imag);
    void Read();
    void Display() const;
    std::string toString() const;
    Complex add(const Complex& b) const;
    Complex sub(const Complex& b) const;
    Complex mul(const Complex& b) const;
    Complex div(const Complex& b) const;
    bool equ(const Complex& b) const;
    Complex conj() const;
};
