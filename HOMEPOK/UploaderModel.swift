//
//  UploaderModel.swift
//  Prestoid - Dropbox sync video camera app with speech to text recognition
//  Application version 1.3, build 21
//
//  Created by Alexander Iashchuk on 2/12/17.
//  Copyright © 2016 Alexander Iashchuk (iAlexander), http://iashchuk.com
//  Application owner - Scott Leatham. All rights reserved.
//

import Foundation
import CoreGraphics

open class ChartBaseDataSet: NSObject
{
    public required override init()
    {
        super.init()
        
        // default color
        colors.append(NSUIColor(red: 140.0/255.0, green: 234.0/255.0, blue: 255.0/255.0, alpha: 1.0))
        valueColors.append(NSUIColor.black)
    }
    
    public init(label: String?)
    {
        super.init()
        
        // default color
        colors.append(NSUIColor(red: 140.0/255.0, green: 234.0/255.0, blue: 255.0/255.0, alpha: 1.0))
        valueColors.append(NSUIColor.black)
        
        self.label = label
    }
    
    // MARK: - Data functions and accessors
    
    /// Use this method to tell the data set that the underlying data has changed
    open func notifyDataSetChanged()
    {
        calcMinMax()
    }
    
    open func calcMinMax()
    {
        fatalError("calcMinMax is not implemented in ChartBaseDataSet")
    }
    
    open func calcMinMaxY(fromX: Double, toX: Double)
    {
        fatalError("calcMinMaxY(fromX:, toX:) is not implemented in ChartBaseDataSet")
    }
    
    open var yMin: Double
    {
        fatalError("yMin is not implemented in ChartBaseDataSet")
    }
    
    open var yMax: Double
    {
        fatalError("yMax is not implemented in ChartBaseDataSet")
    }
    
    open var xMin: Double
    {
        fatalError("xMin is not implemented in ChartBaseDataSet")
    }
    
    open var xMax: Double
    {
        fatalError("xMax is not implemented in ChartBaseDataSet")
    }
    
    open var entryCount: Int
    {
        fatalError("entryCount is not implemented in ChartBaseDataSet")
    }
    
    open func entryForIndex(_ i: Int) -> ChartDataEntry?
    {
        fatalError("entryForIndex is not implemented in ChartBaseDataSet")
    }
    
    open func entryForXValue(
        _ x: Double,
        closestToY y: Double,
        rounding: ChartDataSetRounding) -> ChartDataEntry?
    {
        fatalError("entryForXValue(x, closestToY, rounding) is not implemented in ChartBaseDataSet")
    }
    
    open func entryForXValue(
        _ x: Double,
        closestToY y: Double) -> ChartDataEntry?
    {
        fatalError("entryForXValue(x, closestToY) is not implemented in ChartBaseDataSet")
    }
    
    open func entriesForXValue(_ x: Double) -> [ChartDataEntry]
    {
        fatalError("entriesForXValue is not implemented in ChartBaseDataSet")
    }
    
    open func entryIndex(
        x xValue: Double,
        closestToY y: Double,
        rounding: ChartDataSetRounding) -> Int
    {
        fatalError("entryIndex(x, closestToY, rounding) is not implemented in ChartBaseDataSet")
    }
    
    open func entryIndex(entry e: ChartDataEntry) -> Int
    {
        fatalError("entryIndex(entry) is not implemented in ChartBaseDataSet")
    }
    
    open func addEntry(_ e: ChartDataEntry) -> Bool
    {
        fatalError("addEntry is not implemented in ChartBaseDataSet")
    }
    
    open func addEntryOrdered(_ e: ChartDataEntry) -> Bool
    {
        fatalError("addEntryOrdered is not implemented in ChartBaseDataSet")
    }
    
    open func removeEntry(_ entry: ChartDataEntry) -> Bool
    {
        fatalError("removeEntry is not implemented in ChartBaseDataSet")
    }
    
    open func removeEntry(index: Int) -> Bool
    {
        if let entry = entryForIndex(index)
        {
            return removeEntry(entry)
        }
        return false
    }
    
    open func removeEntry(x: Double) -> Bool
    {
        if let entry = entryForXValue(x, closestToY: Double.nan)
        {
            return removeEntry(entry)
        }
        return false
    }
    
    open func removeFirst() -> Bool
    {
        if entryCount > 0
        {
            if let entry = entryForIndex(0)
            {
                return removeEntry(entry)
            }
        }
        return false
    }
    
    open func removeLast() -> Bool
    {
        if entryCount > 0
        {
            if let entry = entryForIndex(entryCount - 1)
            {
                return removeEntry(entry)
            }
        }
        return false
    }
    
    open func contains(_ e: ChartDataEntry) -> Bool
    {
        fatalError("removeEntry is not implemented in ChartBaseDataSet")
    }
    
    open func clear()
    {
        fatalError("clear is not implemented in ChartBaseDataSet")
    }
    
    // MARK: - Styling functions and accessors
    
    /// All the colors that are used for this DataSet.
    /// Colors are reused as soon as the number of Entries the DataSet represents is higher than the size of the colors array.
    open var colors = [NSUIColor]()
    
    /// List representing all colors that are used for drawing the actual values for this DataSet
    open var valueColors = [NSUIColor]()
    
    /// The label string that describes the DataSet.
    open var label: String? = "DataSet"
    
    /// The axis this DataSet should be plotted against.
    open var axisDependency = YAxis.AxisDependency.left
    
    /// - returns: The color at the given index of the DataSet's color array.
    /// This prevents out-of-bounds by performing a modulus on the color index, so colours will repeat themselves.
    open func color(atIndex index: Int) -> NSUIColor
    {
        var index = index
        if index < 0
        {
            index = 0
        }
        return colors[index % colors.count]
    }
    
    /// Resets all colors of this DataSet and recreates the colors array.
    open func resetColors()
    {
        colors.removeAll(keepingCapacity: false)
    }
    
    /// Adds a new color to the colors array of the DataSet.
    /// - parameter color: the color to add
    open func addColor(_ color: NSUIColor)
    {
        colors.append(color)
    }
    
    /// Sets the one and **only** color that should be used for this DataSet.
    /// Internally, this recreates the colors array and adds the specified color.
    /// - parameter color: the color to set
    open func setColor(_ color: NSUIColor)
    {
        colors.removeAll(keepingCapacity: false)
        colors.append(color)
    }
    
    /// Sets colors to a single color a specific alpha value.
    /// - parameter color: the color to set
    /// - parameter alpha: alpha to apply to the set `color`
    open func setColor(_ color: NSUIColor, alpha: CGFloat)
    {
        setColor(color.withAlphaComponent(alpha))
    }
    
    /// Sets colors with a specific alpha value.
    /// - parameter colors: the colors to set
    /// - parameter alpha: alpha to apply to the set `colors`
    open func setColors(_ colors: [NSUIColor], alpha: CGFloat)
    {
        var colorsWithAlpha = colors
        
        for i in 0 ..< colorsWithAlpha.count
        {
            colorsWithAlpha[i] = colorsWithAlpha[i] .withAlphaComponent(alpha)
        }
        
        self.colors = colorsWithAlpha
    }
    
    /// Sets colors with a specific alpha value.
    /// - parameter colors: the colors to set
    /// - parameter alpha: alpha to apply to the set `colors`
    open func setColors(_ colors: NSUIColor...)
    {
        self.colors = colors
    }
    
    /// if true, value highlighting is enabled
    open var highlightEnabled = true
    
    /// - returns: `true` if value highlighting is enabled for this dataset
    open var isHighlightEnabled: Bool { return highlightEnabled }
    
    /// Custom formatter that is used instead of the auto-formatter if set
    internal var _valueFormatter: IValueFormatter?
    
    /// Custom formatter that is used instead of the auto-formatter if set
    open var valueFormatter: IValueFormatter?
        {
        get
        {
            if needsFormatter
            {
                return ChartUtils.defaultValueFormatter()
            }
            
            return _valueFormatter
        }
        set
        {
            if newValue == nil { return }
            
            _valueFormatter = newValue
        }
    }
    
    open var needsFormatter: Bool
    {
        return _valueFormatter == nil
    }
    
    /// Sets/get a single color for value text.
    /// Setting the color clears the colors array and adds a single color.
    /// Getting will return the first color in the array.
    open var valueTextColor: NSUIColor
        {
        get
        {
            return valueColors[0]
        }
        set
        {
            valueColors.removeAll(keepingCapacity: false)
            valueColors.append(newValue)
        }
    }
    
    /// - returns: The color at the specified index that is used for drawing the values inside the chart. Uses modulus internally.
    open func valueTextColorAt(_ index: Int) -> NSUIColor
    {
        var index = index
        if index < 0
        {
            index = 0
        }
        return valueColors[index % valueColors.count]
    }
    
    /// the font for the value-text labels
    open var valueFont: NSUIFont = NSUIFont.systemFont(ofSize: 7.0)
    
    /// The form to draw for this dataset in the legend.
    open var form = Legend.Form.default
    
    /// The form size to draw for this dataset in the legend.
    ///
    /// Return `NaN` to use the default legend form size.
    open var formSize: CGFloat = CGFloat.nan
    
    /// The line width for drawing the form of this dataset in the legend
    ///
    /// Return `NaN` to use the default legend form line width.
    open var formLineWidth: CGFloat = CGFloat.nan
    
    /// Line dash configuration for legend shapes that consist of lines.
    ///
    /// This is how much (in pixels) into the dash pattern are we starting from.
    open var formLineDashPhase: CGFloat = 0.0
    
    /// Line dash configuration for legend shapes that consist of lines.
    ///
    /// This is the actual dash pattern.
    /// I.e. [2, 3] will paint [--   --   ]
    /// [1, 3, 4, 2] will paint [-   ----  -   ----  ]
    open var formLineDashLengths: [CGFloat]? = nil
    
    /// Set this to true to draw y-values on the chart
    open var drawValuesEnabled = true
    
    /// - returns: `true` if y-value drawing is enabled, `false` ifnot
    open var isDrawValuesEnabled: Bool
    {
        return drawValuesEnabled
    }
    
    /// Set the visibility of this DataSet. If not visible, the DataSet will not be drawn to the chart upon refreshing it.
    open var visible = true
    
    /// - returns: `true` if this DataSet is visible inside the chart, or `false` ifit is currently hidden.
    open var isVisible: Bool
    {
        return visible
    }
    
    // MARK: - NSObject
    
    open override var description: String
    {
        return String(format: "%@, label: %@, %i entries", arguments: [NSStringFromClass(type(of: self)), self.label ?? "", self.entryCount])
    }
    
    open override var debugDescription: String
    {
        var desc = description + ":"
        
        for i in 0 ..< self.entryCount
        {
            desc += "\n" + (self.entryForIndex(i)?.description ?? "")
        }
        
        return desc
    }
    
    // MARK: - NSCopying
    
    open func copyWithZone(_ zone: NSZone?) -> AnyObject
    {
        let copy = type(of: self).init()
        
        copy.colors = colors
        copy.valueColors = valueColors
        copy.label = label
        
        return copy
    }
}

@objc
public protocol IBarChartDataSet: IBarLineScatterCandleBubbleChartDataSet
{
    // MARK: - Data functions and accessors
    
    // MARK: - Styling functions and accessors
    
    /// - returns: `true` if this DataSet is stacked (stacksize > 1) or not.
    var isStacked: Bool { get }
    
    /// - returns: The maximum number of bars that can be stacked upon another in this DataSet.
    var stackSize: Int { get }
    
    /// the color used for drawing the bar-shadows. The bar shadows is a surface behind the bar that indicates the maximum value
    var barShadowColor: NSUIColor { get set }
    
    /// the width used for drawing borders around the bars. If borderWidth == 0, no border will be drawn.
    var barBorderWidth : CGFloat { get set }
    
    /// the color drawing borders around the bars.
    var barBorderColor: NSUIColor { get set }
    
    /// the alpha value (transparency) that is used for drawing the highlight indicator bar. min = 0.0 (fully transparent), max = 1.0 (fully opaque)
    var highlightAlpha: CGFloat { get set }
    
    /// array of labels used to describe the different values of the stacked bars
    var stackLabels: [String] { get set }
}

@objc
public protocol IBarLineScatterCandleBubbleChartDataSet: IChartDataSet
{
    // MARK: - Data functions and accessors
    
    // MARK: - Styling functions and accessors
    
    var highlightColor: NSUIColor { get set }
    var highlightLineWidth: CGFloat { get set }
    var highlightLineDashPhase: CGFloat { get set }
    var highlightLineDashLengths: [CGFloat]? { get set }
}

@objc
public protocol ICandleChartDataSet: ILineScatterCandleRadarChartDataSet
{
    // MARK: - Data functions and accessors
    
    // MARK: - Styling functions and accessors
    
    /// the space that is left out on the left and right side of each candle,
    /// **default**: 0.1 (10%), max 0.45, min 0.0
    var barSpace: CGFloat { get set }
    
    /// should the candle bars show?
    /// when false, only "ticks" will show
    ///
    /// **default**: true
    var showCandleBar: Bool { get set }
    
    /// the width of the candle-shadow-line in pixels.
    ///
    /// **default**: 3.0
    var shadowWidth: CGFloat { get set }
    
    /// the color of the shadow line
    var shadowColor: NSUIColor? { get set }
    
    /// use candle color for the shadow
    var shadowColorSameAsCandle: Bool { get set }
    
    /// Is the shadow color same as the candle color?
    var isShadowColorSameAsCandle: Bool { get }
    
    /// color for open == close
    var neutralColor: NSUIColor? { get set }
    
    /// color for open > close
    var increasingColor: NSUIColor? { get set }
    
    /// color for open < close
    var decreasingColor: NSUIColor? { get set }
    
    /// Are increasing values drawn as filled?
    var increasingFilled: Bool { get set }
    
    /// Are increasing values drawn as filled?
    var isIncreasingFilled: Bool { get }
    
    /// Are decreasing values drawn as filled?
    var decreasingFilled: Bool { get set }
    
    /// Are decreasing values drawn as filled?
    var isDecreasingFilled: Bool { get }
}

@objc(ChartAnimatorDelegate)
public protocol AnimatorDelegate
{
    /// Called when the Animator has stepped.
    func animatorUpdated(_ animator: Animator)
    
    /// Called when the Animator has stopped.
    func animatorStopped(_ animator: Animator)
}

@objc(ChartAnimator)
open class Animator: NSObject
{
    open weak var delegate: AnimatorDelegate?
    open var updateBlock: (() -> Void)?
    open var stopBlock: (() -> Void)?
    
    /// the phase that is animated and influences the drawn values on the x-axis
    open var phaseX: Double = 1.0
    
    /// the phase that is animated and influences the drawn values on the y-axis
    open var phaseY: Double = 1.0
    
    fileprivate var _startTimeX: TimeInterval = 0.0
    fileprivate var _startTimeY: TimeInterval = 0.0
    fileprivate var _displayLink: NSUIDisplayLink?
    
    fileprivate var _durationX: TimeInterval = 0.0
    fileprivate var _durationY: TimeInterval = 0.0
    
    fileprivate var _endTimeX: TimeInterval = 0.0
    fileprivate var _endTimeY: TimeInterval = 0.0
    fileprivate var _endTime: TimeInterval = 0.0
    
    fileprivate var _enabledX: Bool = false
    fileprivate var _enabledY: Bool = false
    
    fileprivate var _easingX: ChartEasingFunctionBlock?
    fileprivate var _easingY: ChartEasingFunctionBlock?
    
    public override init()
    {
        super.init()
    }
    
    deinit
    {
        stop()
    }
    
    open func stop()
    {
        if _displayLink != nil
        {
            _displayLink?.remove(from: RunLoop.main, forMode: RunLoopMode.commonModes)
            _displayLink = nil
            
            _enabledX = false
            _enabledY = false
            
            // If we stopped an animation in the middle, we do not want to leave it like this
            if phaseX != 1.0 || phaseY != 1.0
            {
                phaseX = 1.0
                phaseY = 1.0
                
                if delegate != nil
                {
                    delegate!.animatorUpdated(self)
                }
                if updateBlock != nil
                {
                    updateBlock!()
                }
            }
            
            if delegate != nil
            {
                delegate!.animatorStopped(self)
            }
            if stopBlock != nil
            {
                stopBlock?()
            }
        }
    }
    
    fileprivate func updateAnimationPhases(_ currentTime: TimeInterval)
    {
        if _enabledX
        {
            let elapsedTime: TimeInterval = currentTime - _startTimeX
            let duration: TimeInterval = _durationX
            var elapsed: TimeInterval = elapsedTime
            if elapsed > duration
            {
                elapsed = duration
            }
            
            if _easingX != nil
            {
                phaseX = _easingX!(elapsed, duration)
            }
            else
            {
                phaseX = Double(elapsed / duration)
            }
        }
        
        if _enabledY
        {
            let elapsedTime: TimeInterval = currentTime - _startTimeY
            let duration: TimeInterval = _durationY
            var elapsed: TimeInterval = elapsedTime
            if elapsed > duration
            {
                elapsed = duration
            }
            
            if _easingY != nil
            {
                phaseY = _easingY!(elapsed, duration)
            }
            else
            {
                phaseY = Double(elapsed / duration)
            }
        }
    }
    
    @objc fileprivate func animationLoop()
    {
        let currentTime: TimeInterval = CACurrentMediaTime()
        
        updateAnimationPhases(currentTime)
        
        if delegate != nil
        {
            delegate!.animatorUpdated(self)
        }
        if updateBlock != nil
        {
            updateBlock!()
        }
        
        if currentTime >= _endTime
        {
            stop()
        }
    }
    
    /// Animates the drawing / rendering of the chart on both x- and y-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter xAxisDuration: duration for animating the x axis
    /// - parameter yAxisDuration: duration for animating the y axis
    /// - parameter easingX: an easing function for the animation on the x axis
    /// - parameter easingY: an easing function for the animation on the y axis
    open func animate(xAxisDuration: TimeInterval, yAxisDuration: TimeInterval, easingX: ChartEasingFunctionBlock?, easingY: ChartEasingFunctionBlock?)
    {
        stop()
        
        _startTimeX = CACurrentMediaTime()
        _startTimeY = _startTimeX
        _durationX = xAxisDuration
        _durationY = yAxisDuration
        _endTimeX = _startTimeX + xAxisDuration
        _endTimeY = _startTimeY + yAxisDuration
        _endTime = _endTimeX > _endTimeY ? _endTimeX : _endTimeY
        _enabledX = xAxisDuration > 0.0
        _enabledY = yAxisDuration > 0.0
        
        _easingX = easingX
        _easingY = easingY
        
        // Take care of the first frame if rendering is already scheduled...
        updateAnimationPhases(_startTimeX)
        
        if _enabledX || _enabledY
        {
            _displayLink = NSUIDisplayLink(target: self, selector: #selector(animationLoop))
            _displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
        }
    }
    
    /// Animates the drawing / rendering of the chart on both x- and y-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter xAxisDuration: duration for animating the x axis
    /// - parameter yAxisDuration: duration for animating the y axis
    /// - parameter easingOptionX: the easing function for the animation on the x axis
    /// - parameter easingOptionY: the easing function for the animation on the y axis
    open func animate(xAxisDuration: TimeInterval, yAxisDuration: TimeInterval, easingOptionX: ChartEasingOption, easingOptionY: ChartEasingOption)
    {
        animate(xAxisDuration: xAxisDuration, yAxisDuration: yAxisDuration, easingX: easingFunctionFromOption(easingOptionX), easingY: easingFunctionFromOption(easingOptionY))
    }
    
    /// Animates the drawing / rendering of the chart on both x- and y-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter xAxisDuration: duration for animating the x axis
    /// - parameter yAxisDuration: duration for animating the y axis
    /// - parameter easing: an easing function for the animation
    open func animate(xAxisDuration: TimeInterval, yAxisDuration: TimeInterval, easing: ChartEasingFunctionBlock?)
    {
        animate(xAxisDuration: xAxisDuration, yAxisDuration: yAxisDuration, easingX: easing, easingY: easing)
    }
    
    /// Animates the drawing / rendering of the chart on both x- and y-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter xAxisDuration: duration for animating the x axis
    /// - parameter yAxisDuration: duration for animating the y axis
    /// - parameter easingOption: the easing function for the animation
    open func animate(xAxisDuration: TimeInterval, yAxisDuration: TimeInterval, easingOption: ChartEasingOption)
    {
        animate(xAxisDuration: xAxisDuration, yAxisDuration: yAxisDuration, easing: easingFunctionFromOption(easingOption))
    }
    
    /// Animates the drawing / rendering of the chart on both x- and y-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter xAxisDuration: duration for animating the x axis
    /// - parameter yAxisDuration: duration for animating the y axis
    open func animate(xAxisDuration: TimeInterval, yAxisDuration: TimeInterval)
    {
        animate(xAxisDuration: xAxisDuration, yAxisDuration: yAxisDuration, easingOption: .easeInOutSine)
    }
    
    /// Animates the drawing / rendering of the chart the x-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter xAxisDuration: duration for animating the x axis
    /// - parameter easing: an easing function for the animation
    open func animate(xAxisDuration: TimeInterval, easing: ChartEasingFunctionBlock?)
    {
        _startTimeX = CACurrentMediaTime()
        _durationX = xAxisDuration
        _endTimeX = _startTimeX + xAxisDuration
        _endTime = _endTimeX > _endTimeY ? _endTimeX : _endTimeY
        _enabledX = xAxisDuration > 0.0
        
        _easingX = easing
        
        // Take care of the first frame if rendering is already scheduled...
        updateAnimationPhases(_startTimeX)
        
        if _enabledX || _enabledY
        {
            if _displayLink == nil
            {
                _displayLink = NSUIDisplayLink(target: self, selector: #selector(animationLoop))
                _displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
            }
        }
    }
    
    /// Animates the drawing / rendering of the chart the x-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter xAxisDuration: duration for animating the x axis
    /// - parameter easingOption: the easing function for the animation
    open func animate(xAxisDuration: TimeInterval, easingOption: ChartEasingOption)
    {
        animate(xAxisDuration: xAxisDuration, easing: easingFunctionFromOption(easingOption))
    }
    
    /// Animates the drawing / rendering of the chart the x-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter xAxisDuration: duration for animating the x axis
    open func animate(xAxisDuration: TimeInterval)
    {
        animate(xAxisDuration: xAxisDuration, easingOption: .easeInOutSine)
    }
    
    /// Animates the drawing / rendering of the chart the y-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter yAxisDuration: duration for animating the y axis
    /// - parameter easing: an easing function for the animation
    open func animate(yAxisDuration: TimeInterval, easing: ChartEasingFunctionBlock?)
    {
        _startTimeY = CACurrentMediaTime()
        _durationY = yAxisDuration
        _endTimeY = _startTimeY + yAxisDuration
        _endTime = _endTimeX > _endTimeY ? _endTimeX : _endTimeY
        _enabledY = yAxisDuration > 0.0
        
        _easingY = easing
        
        // Take care of the first frame if rendering is already scheduled...
        updateAnimationPhases(_startTimeY)
        
        if _enabledX || _enabledY
        {
            if _displayLink == nil
            {
                _displayLink = NSUIDisplayLink(target: self, selector: #selector(animationLoop))
                _displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
            }
        }
    }
    
    /// Animates the drawing / rendering of the chart the y-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter yAxisDuration: duration for animating the y axis
    /// - parameter easingOption: the easing function for the animation
    open func animate(yAxisDuration: TimeInterval, easingOption: ChartEasingOption)
    {
        animate(yAxisDuration: yAxisDuration, easing: easingFunctionFromOption(easingOption))
    }
    
    /// Animates the drawing / rendering of the chart the y-axis with the specified animation time.
    /// If `animate(...)` is called, no further calling of `invalidate()` is necessary to refresh the chart.
    /// - parameter yAxisDuration: duration for animating the y axis
    open func animate(yAxisDuration: TimeInterval)
    {
        animate(yAxisDuration: yAxisDuration, easingOption: .easeInOutSine)
    }
}
